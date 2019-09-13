Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF40FB2259
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfIMOhO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 10:37:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35379 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfIMOgK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Sep 2019 10:36:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so32422551wrx.2
        for <linux-arch@vger.kernel.org>; Fri, 13 Sep 2019 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fi7MGMz30BGFBES8k6hGqqMwOoWqphog01tFwnQ6SdE=;
        b=oXmx3Bcm4EJnSsdjPS720KqWa6XRtQrUOC1KqnJ8tSvcCWW3xKTRL84zQpAElnw1mD
         rDmtkL8kDG0fNpkEfM8EO2TpeUQSfW67AxrDC6gQeYr6dL/Ch578ne7wHGBTW4LrUnCZ
         5znRlsQYdweRlajAmhIaTZt4HI5/ouHxZP6wWg6RcdsURD/SO0Y4S/ebC64Aq6uQysXJ
         8w+MGMl6ru9Bmi2yreEnN7mK71IQ5l0jM6c85kj/n90ypbqqPqozPmqwQuLPPMZhmEWq
         pOdJXSsdGuP+xBhmsd0OgXy5HL4JoQ55AJeelF0PwNfrzCdscB4Z4nDfxFfKtyR898Uz
         uzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fi7MGMz30BGFBES8k6hGqqMwOoWqphog01tFwnQ6SdE=;
        b=gLFBLdjNfOp7znMTgsBPduE04JQ96Y4/zcExB2BZi3DquUy9r719IKi1dLKEs0lFgM
         yVkm0jxP1LHWrmb8oQXK6sYmDEclGZkGV/z/A7iXV5qx4l2M+NbvevgR9oEkLBFNGQ82
         xRPjNs0hHmOE1oQzaTGkj4asuzIjtjcgM2K3p61E6PwWbU7tl9aWE0GYAiLzS3e86BLg
         9IzNekQOm/9S/88Pzvqw0Bj7ljxP8a/MpSlcaNTOvjEXqt31dzIH6GB8VmNcjZfA/XVE
         0S/uzNkYOnT/LM+ph0OewxZk1zZqyItux5sCdN/qV9orOsEh6Mg9zooe19YUs5YAB2hS
         UfyA==
X-Gm-Message-State: APjAAAWRXL72RuKevHgLCRCB4P+P6Os5jcUINJIedFGjq67lz8Rx17oD
        br5J2j4zA7bnGFSppEV3VmM=
X-Google-Smtp-Source: APXvYqw/BTeDn76GkqfI4d650bMkBQUbcN+HqR33ZgBBE46QWNNuHfdWkT0ngJU1HAbwa22ejceRFA==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr5709864wrq.336.1568385368058;
        Fri, 13 Sep 2019 07:36:08 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id z142sm5389326wmc.24.2019.09.13.07.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 07:36:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] tty: add bits to manage multidrop mode
To:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-arch@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Rodolfo Giometti <giometti@linux.it>,
        Joshua Henderson <joshua.henderson@microchip.com>
References: <20190912084032.16927-1-giometti@enneenne.com>
 <20190912084032.16927-2-giometti@enneenne.com>
 <c9860c7f-bd06-86aa-c3c0-74e2e1617cae@gmail.com>
 <c7a63468-4e29-2bbd-912d-4583098507af@enneenne.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <f0071444-7885-db74-ba50-17f3e7fae1f7@gmail.com>
Date:   Fri, 13 Sep 2019 16:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c7a63468-4e29-2bbd-912d-4583098507af@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 12/09/2019 à 14:47, Rodolfo Giometti a écrit :
> On 12/09/2019 13:01, Richard Genoud wrote:
>> Hi Rodolfo,
>>
>> You could also add these mailing lists:
>> - linux-serial@vger.kernel.org
>> - linux-arm-kernel@lists.infradead.org
>> - linux-kernel@vger.kernel.org
> 
> OK. No problem!
> 
>> For reference, I've dug the conversation we had 2 years ago:
>> 0/2 : https://marc.info/?t=149192176100002&r=1&w=2
>> 1/2 : https://marc.info/?t=149192176300001&r=1&w=2
>> 2/2 : https://marc.info/?t=149192176700001&r=1&w=2
> 
> Thanks.
> 
>> And, like I said at that time, one problem I see with this
>> implementation (setting a SENDA bit that automatically unsets itself)
>> will break the way tcgetattr() is working:
>> https://marc.info/?l=linux-serial&m=149209522108027&w=2
> 
> I see... however the problem here is that this attribute is not sticky and it is
> reset by the controller after the first byte as been sent. Here is how
> Atmel/Microchip multidrop works (from the SAMA5D3's datasheet):
> 
> 44.7.3.9 Multidrop Mode
> If the value 0x6 or 0x07 is written to the PAR field in the US_MR, the USART
> runs in Multidrop Mode. This mode differentiates the data characters and the
> address characters. Data is transmitted with the parity bit to 0 and addresses
> are transmitted with the parity bit to 1.
> ...
> The transmitter sends an address byte (parity bit set) when SENDA is written to
> in the US_CR. In this case, the next byte written to the US_THR is transmitted
> as an address. Any character written in the US_THR without having written the
> command SENDA is transmitted normally with the parity to 0.
> 
> So, if we have a 4 bytes message where the first one is the address byte we can
> use multidrop by setting the SENDA bit at the beginning and then by just
> invoking a write() with the four bytes message. The controller automatically
> will set the 9th bit to 1 for the first byte and then to 0 for the following
> three bytes.
> 
> To do so we need a syscall to tell to the controller when the address bit
> (SENDA) must be set, each time, before sending the message.
> 
> In this implementation I used the syscall within tcsetattr() function but if
> this is not right, then I have to use another one... maybe a custom ioctl? Or
> can you please suggest a suitable solution? :-)
What's bothering me with this implementation, is that it's too close to
the hardware. Some other micro-controllers may not have the SENDA bit.
For instance, i.MX6ULL:
--->8----
To transmit 9-bit RS-485 frames, user need to enable parity (PREN=1) to
enable
trasmitting the ninth data bit, set 8-bit data word size (WS=1), and
write TXB8
(UMCR[2]) as the 9 th bit (bit [8]) to be transmitted (write '0' to TXB8
to transmit a data
frame, write '1' to transmit a address frame). The other data bit [7:0]
is written to TxFIFO
by writing to the UTXD same as normal RS-232 operation.
---8<----
And the TXB8 bit doesn't seem to clear itself automatically.

I maybe wrong, but I think that writing a line discipline for multidrop
mode would be more versatile.


Regards,
Richard

> 
> Thanks for your help,
> 
> Rodolfo Giometti
> 

