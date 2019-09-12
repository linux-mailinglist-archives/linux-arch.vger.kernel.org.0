Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA9FB0D74
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2019 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfILLBw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Sep 2019 07:01:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfILLBv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 07:01:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id k6so15794899wrn.11
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2019 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nC0AsqkfhvsRzaPPuGb1eSboQi7oxzAgKYOjlnOrGaw=;
        b=LCjIxJEX0Fr8I5Pe5Bdu1zmex6eHJsaJLJ0G3I88Hkbds4q79zbIO3G7cTsZ4yIHkh
         A5YUWfSimEBp0tsVQ3K7Rzy/axuXUuBVEwTVYnOzizvsqRAOo4onYaQHTxD2MJXiwwbh
         E34h5XI/BwuawOURJ5er7NVVyH/7r4agy0VkSgqR/gxGS2rpGnOfGh2rkj48fFxWGP5j
         2yjbmCFFVcXEHNhZW6telRW+hwcugksyij9N8XycRXjacijp+zob9GovTQdXjWegUTFD
         VtKfLPeh5IsB3WgICbY8KUs0JfZgJhGd1QoFjHFVEU4S/llDrbpiz/2EQFJ1jGX3de5i
         t1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nC0AsqkfhvsRzaPPuGb1eSboQi7oxzAgKYOjlnOrGaw=;
        b=WD7e0QgpW+GVEN7ug6z90eAgFpUsGeYBvQmzcEAPwFEzD27W3Xot0paMo5bxweXO34
         7H2qSpPsS/witOGplEChJ28P/eizCRqQXkd3lByR5mfWtwL1wvbKgA7omVzsa0C/BqdA
         TnUR0Ue1JA/LeRLfNwlyuGEDoEjnJNTIqNE9hQV7bJsTS9R+fWO4yGgQvQHiAAZqLKbD
         WIBd7Jqtx2hFgcySVtCwCaH4hZKEDnyfqtR671rB4h5ed1crhIM8VS3DWLm0NFr9HWtM
         iPelKnMVFusrVybNryICY1Zv1S02I3fiRw6o5Leag76WyaAWF1AbGdk2bxNykrmO+xmM
         Y/yA==
X-Gm-Message-State: APjAAAWfRGkowuBmchAP3v6mE8AO344/XBnFzRgSKjdsVrfGQ42H8Sqj
        R/MkuOa8QHC6hsQ0eVa8pRk=
X-Google-Smtp-Source: APXvYqyicVuAdQVEvJGX6fWzERn3UdO4VM0mJ+Wji2wrQZrLvrVUyuBH3pyP6kt5Zd98Xez82gR0uA==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr33848618wrn.299.1568286109620;
        Thu, 12 Sep 2019 04:01:49 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id q25sm7229458wmq.27.2019.09.12.04.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:01:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] tty: add bits to manage multidrop mode
To:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-arch@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Rodolfo Giometti <giometti@linux.it>,
        Joshua Henderson <joshua.henderson@microchip.com>
References: <20190912084032.16927-1-giometti@enneenne.com>
 <20190912084032.16927-2-giometti@enneenne.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <c9860c7f-bd06-86aa-c3c0-74e2e1617cae@gmail.com>
Date:   Thu, 12 Sep 2019 13:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912084032.16927-2-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rodolfo,

You could also add these mailing lists:
- linux-serial@vger.kernel.org
- linux-arm-kernel@lists.infradead.org
- linux-kernel@vger.kernel.org

For reference, I've dug the conversation we had 2 years ago:
0/2 : https://marc.info/?t=149192176100002&r=1&w=2
1/2 : https://marc.info/?t=149192176300001&r=1&w=2
2/2 : https://marc.info/?t=149192176700001&r=1&w=2

And, like I said at that time, one problem I see with this
implementation (setting a SENDA bit that automatically unsets itself)
will break the way tcgetattr() is working:
https://marc.info/?l=linux-serial&m=149209522108027&w=2


Le 12/09/2019 à 10:40, Rodolfo Giometti a écrit :
> From: Rodolfo Giometti <giometti@linux.it>
> 
> Multidrop mode differentiates the data characters and the address
> characters. Data is transmitted with the parity bit to 0 and addresses
> are transmitted with the parity bit to 1. However this usually slow
> down communication by adding a delay between the first byte and the
> others.
> 
> This patch defines two non-stadard bits PARMD (that enables multidrop)
> and SENDA (that marks the next transmitted byte as address) that can
> be used to completely remove the delay during transmission by
> correctly managing the parity bit generation in hardware.
> 
> A simple example code about how to set up it is reported below:
> 
>     struct termios term;
> 
>     tcgetattr(fd, &term);
> 
>     /* Transmission: enable parity multidrop and mark 1st byte as address */
>     term.c_cflag |= PARENB | CMSPAR | PARMD | SENDA;
>     /* Reception: enable parity multidrop and parity check */
>     term.c_iflag |= PARENB | PARMD | INPCK;
> 
>     tcsetattr(fd, TCSADRAIN, &term);
> 
> After that we can start 9 bits data transmission.
> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>  include/linux/tty.h                 | 2 ++
>  include/uapi/asm-generic/termbits.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index bfa4e2ee94a9..66a25294f125 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -168,6 +168,8 @@ struct tty_bufhead {
>  #define C_CIBAUD(tty)	_C_FLAG((tty), CIBAUD)
>  #define C_CRTSCTS(tty)	_C_FLAG((tty), CRTSCTS)
>  #define C_CMSPAR(tty)	_C_FLAG((tty), CMSPAR)
> +#define C_PARMD(tty)	_C_FLAG((tty), PARMD)
> +#define C_SENDA(tty)	_C_FLAG((tty), SENDA)
>  
>  #define L_ISIG(tty)	_L_FLAG((tty), ISIG)
>  #define L_ICANON(tty)	_L_FLAG((tty), ICANON)
> diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
> index 2fbaf9ae89dd..ead5eaebdd3b 100644
> --- a/include/uapi/asm-generic/termbits.h
> +++ b/include/uapi/asm-generic/termbits.h
> @@ -141,6 +141,8 @@ struct ktermios {
>  #define HUPCL	0002000
>  #define CLOCAL	0004000
>  #define CBAUDEX 0010000
> +#define PARMD   040000000
> +#define SENDA   0100000000
>  #define    BOTHER 0010000
>  #define    B57600 0010001
>  #define   B115200 0010002
> 

