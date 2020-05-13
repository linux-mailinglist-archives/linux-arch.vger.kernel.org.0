Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57C11D1247
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbgEMMGm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 08:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgEMMGl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 08:06:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D43C061A0C;
        Wed, 13 May 2020 05:06:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so6638715wrt.5;
        Wed, 13 May 2020 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fhDNmmvpzcm8F44Tpv9IkktsDhvARR3ewt8RuiOuBoA=;
        b=beeHv2OAHYMxvQRdS0dGGTcvJZSVDRI8XdA2wxJmK9wwv+MDp31Gd5wu3TselVR2/8
         rmN9sAkbrajGgJenRb/nwB9p7z80N7YObbaYKItKby8SGY9Mkm+qj29KUUXDcSQ3XKfE
         BV4YxjHVkMG16zNhHHyyVW9RlDbheebn2ZmyCURlG14mk061hXorpdzcgcA94kqYcY3D
         SauCek2rrKM9o3GZwejTQh+M1XCjElH9zvNrn1QUTv4gnzxhsbnPyE2QDzYmsEvi19iu
         dXpVlHutjrawC61GVZuOGn7OHsTb5zLcfOv9qZJaAV66f+tkx7vq1jYFJ+uZACFG0w8W
         ksKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fhDNmmvpzcm8F44Tpv9IkktsDhvARR3ewt8RuiOuBoA=;
        b=em1SyTm7hXbVuowsn54v4xilgQx97wk3sni/YyvdBgC6Ucxxm0H6fAiNo9+7s4drGy
         fZXA9Ee+ormTGIp6hcgumNzrLlDae+s/kHub82WeHOCETPgX5qCo2T8EezyugOT8DgP2
         X7VOldBvQSj4nPGjyFitU9moNzkUp0Mq1bG0/StRhMEEVePAsxfYkH+h6RCM4YwBtwX2
         5tz5pRhEfxZstaDUlzWZ6tVxCCsCXccsODC4RcQhtbDX6+3S8jZTnRhrbZ+PqXxQhL7P
         IX3eWOdbQEN1NzEJ01hqOGA8COdBiSYbzU5ryZ8TEA6L3+GdQxqsXreWyyi2UYae1X9B
         VU/w==
X-Gm-Message-State: AGi0PuZyer3kW7EcEqVii4d2QWmZ1/WZbNiCF/2z97vrCWt53+6BLZ0m
        QXgmxQtio92PjxyIePlYDLo=
X-Google-Smtp-Source: APiQypJ+JkfUFgeVGuy2lwVKtUdi+R+XLHBgJnoRbjyKUvjsmd6yl5GVgPkk19ITONcmJLFxERAcJA==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr30432002wrr.400.1589371599386;
        Wed, 13 May 2020 05:06:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id p8sm26809589wre.11.2020.05.13.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 05:06:38 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/14] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
 <bd548916-11c8-a53f-67b5-876c79088258@gmail.com>
 <20200513114915.GL21779@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <604879eb-1c7e-d08b-a6b8-165e4259b60c@gmail.com>
Date:   Wed, 13 May 2020 14:06:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513114915.GL21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/13/20 1:49 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 01:21:12PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
>>> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>
>> Thanks. Patch applied, but not yet pushed while I wait to see if any
>> Review/Ack arrives.
>>
>> Also, could you please check the tweaks I note below.
>>
>>> ---
>>>  man2/prctl.2 | 24 ++++++++++++++++++------
>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/man2/prctl.2 b/man2/prctl.2
>>> index e8eaf95..66417cf 100644
>>> --- a/man2/prctl.2
>>> +++ b/man2/prctl.2
>>> @@ -1213,11 +1213,20 @@ arguments must be specified as 0; otherwise the call fails with the error
>>>  .\" commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee
>>>  Sets the state of the speculation misfeature specified in
>>>  .IR arg2 .
>>> -Currently, the only permitted value for this argument is
>>> +Currently, this argument must be one of:
>>> +.RS
>>> +.TP
>>>  .B PR_SPEC_STORE_BYPASS
>>> -(otherwise the call fails with the error
>>> +speculative store bypass control, or
>>
>> s/speculative/enable speculative/
>>
>>> +.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
>>> +.TP
>>> +.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
>>> +indirect branch speculation control.
>>
>> s/indirect/enable indirect/
> 
> That doesn't seem quite right.

My goof, not looking at the bigger context of the patch.

> 
> arg2 just identifies what behaviour to configure.
> It's arg3 that says whether to disable / enable it or whatever.
> 
> 
> While editing this I did wonder whether the "control" was helpful.
> Maybe just dropping that word from these entries would help.

Okay I tried to fix things, and made also some other edits.
How does the following look to you?

      PR_SET_SPECULATION_CTRL (since Linux 4.17)
              Sets the state of the speculation misfeature  specified  in
              arg2.   The  speculation-misfeature settings are per-thread
              attributes.

              Currently, arg2 must be one of:

              PR_SPEC_STORE_BYPASS
                     Set the state of the speculative store  bypass  mis‐
                     feature.

              PR_SPEC_INDIRECT_BRANCH (since Linux 4.20)
                     Set  the  state  of  the indirect branch speculation
                     misfeature.

              If arg2 does not have one of the  above  values,  then  the
              call fails with the error ENODEV.

              The  arg3  argument  is  used to hand in the control value,
              which is one of the following:

              ...

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
