Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12823BA3D9
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhGBSKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBSKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 14:10:34 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F88DC061762;
        Fri,  2 Jul 2021 11:08:01 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cn9so3421147qvb.3;
        Fri, 02 Jul 2021 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oMUyVVAvMFJrr6EX64aXQFDIL61RBU3XqCzFnhQssG4=;
        b=Y72HmJuuDzX0TavkIgDtuWaUuSwMJkubIKxudISMvENuqlMV7QZt/2aiZeGyHcf2MI
         ulU4pDQ4tJDJJt7EIy54MeEZBkEBLNr3UQJe8/H32CAhahYn8ho/L0WjMMkVML8yRK4z
         +9JWP9OMx+Kac+MX8q0h/PTd0vbWY7JygBDhaFEkCeEmnYopLRSKFgNc2S/yIP440gdA
         YL4/7cS6JKjazM7+eWskuVpYJjmGTteIH/fsL5DnkhI8zbraldhezgHFn34673kP5Pvc
         5xYEHBxk/+fRudXN3PeyN6Ss8NG1VMPhokMX8J/J3mmhyrIS35iE0ZcvYfjbRDV0tTE6
         tt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oMUyVVAvMFJrr6EX64aXQFDIL61RBU3XqCzFnhQssG4=;
        b=sprS2iM2Rvc2DBh50zJggptOXHIPCGuugGcaLn5gqgzcIRsyvO8gIu6WuCAWam4bXk
         iSlA5gg0mcpNzh/ojN7sON7Z92XjH4kjMidxCjz4IPuoC+ZhJK9yUCAeL2tUwksxADTp
         DZKoIhHY+4Tf+c7bBRDj9eVn3bvp1X+h6Sf4bRwvscmQgCjuzYSJHAqObzNHt0iOBhPX
         2o2ZrnKm76+pWR7Ugc4jvTrjCJzZxOGJy4qXar830KR31Dt9R1Tv75zW8Epi7szchgqD
         Imhdt+liFJj5Yt0aiiYGxnrJFxNOPyL7oAAlYCkDPDQxiNMhkBUkK9f1wJUtjfTO8MCZ
         MmmQ==
X-Gm-Message-State: AOAM533DCPWyvH587Xj4QfOz0Cro7eoQ1cyYciwqMv4nZHxnrPDupGir
        IVDt4mJU7CFuY09qRyUaQ6A=
X-Google-Smtp-Source: ABdhPJzecI1HSQ00hVIZuX3OGvsXiyfn/lsAQ5DD9nKpPTlj6GjI1/PrC9M8cQZMvy1CUeln8UYLKQ==
X-Received: by 2002:ad4:4666:: with SMTP id z6mr707715qvv.60.1625249280326;
        Fri, 02 Jul 2021 11:08:00 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id f10sm1496462qtq.48.2021.07.02.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 11:07:59 -0700 (PDT)
Date:   Fri, 2 Jul 2021 11:07:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-audit/audit-kernel 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>
Cc:     linux-audit/audit-kernel <audit-kernel@noreply.github.com>,
        Mention <mention@noreply.github.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        bobo.shaobowang@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails
 to properly handle 64-bit syscalls when executing as 32-bit application on
 ARM (#131)
Message-ID: <YN9V/qM0mxIYXt3h@yury-ThinkPad>
References: <linux-audit/audit-kernel/issues/131@github.com>
 <linux-audit/audit-kernel/issues/131/872191450@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <linux-audit/audit-kernel/issues/131/872191450@github.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 01, 2021 at 05:08:45AM -0700, Paul Moore wrote:

[CC ILP32 list]

Weiyuchen wrote:

> I use ILP32 program on 5.10 kernel Recently, and I find that I can't recored log in some case, here is a example:

The last supported kernel version by me is 5.2. Did you port the ilp32
to 5.10 by youself? Can you please share this work?

> I set one rule on the system:
> 
>> auditctl -w /etc/shadow -p wa -k test
> 
> my test program's core func is:
> 
>> open("/etc/shadow", O_WRONLY | O_APPEND);
> 
> when I use 64 bit program to access /etc/shadow, I can get audit log rightly
> but when I use ILP32 program, I can't get any audit log
> 
> I analyse this problem for days, and I find it's due to this commit:
> 
>> 0fe4141ba63a5dfd425c6d2dd9d8cbafd3497946
>> .......
>>  #define AUDIT_ARCH_AARCH64     (EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>> +#define AUDIT_ARCH_AARCH64ILP32        (EM_AARCH64|__AUDIT_ARCH_LE)
>>  #define AUDIT_ARCH_ALPHA       (EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>>  #define AUDIT_ARCH_ARCOMPACT   (EM_ARCOMPACT|__AUDIT_ARCH_LE)
>>  #define AUDIT_ARCH_ARCOMPACTBE (EM_ARCOMPACT) 

I cannot see this commit in Linux mainline. Can you point me to the
exact git repo?

> Beacuse of ILP32 program use 64 bit syscall in most case
> （according to the arm ilp32 Documents：）
> when audit enter audit_classify_syscall function, it turns to a branch different from the kernel without AUDIT_ARCH_AARCH64ILP32 defination, however the syscall num on both kernel is same, so audit can't recognize the 64 bit syscall num when it runs to 32ILP branch

I've never seen this bug before. Can you please check if it exists in
4.9 or 5.2 versions? Can you share the full reproducer and/or
corresponding test in LTP?

---

Paul Moore wrote:

> >From the ILP32 whitepaper:
> > What is ILP32?
> >
> > The ARMv8 architecture supports 32-bit and 64-bit instruction sets (AArch32 and AArch64
> respectively), both use 32-bit instruction encodings but with different register lengths and data
> type sizes.
> >
> > ILP32 is intended for use where, for whatever reason, it is beneficial to use int, long and pointer
> represented as 32-bit values. This could be for performance or legacy 32-bit compatibility
> reasons.
> >
> > Linux on AArch64 uses LP64 as its standard data model, where Long and Pointer are 64-bit,
> Ints are 32-bit.
> >
> > AArch64-ILP32 uses the AArch64 instruction set coupled with a data model where Int, Long
> and Pointer are 32-bit.
> 
> ... which means that ILP32 is basically the ARM version of x32.  Which is pretty much just the worst thing ever; x32 needed to die a painful death and my initial thought is that ILP32 deserves the same fate.

ARM64/ILP32 is not a version of x32. ABI concept and implementation
are different. I understand your criticism about x32, but this project
is closer to mips, spark or power compatibility layers.

In the kernel we have more than 10 implementations of compatibility
layers, and only one causes serious troubles, AFAIK.

> @weiyuchen we will add this to the queue to investigate but it may take a while; if you are interested in working on it you are always welcome to submit patches.
> 
> -- 
> You are receiving this because you were mentioned.
> Reply to this email directly or view it on GitHub:
> https://github.com/linux-audit/audit-kernel/issues/131#issuecomment-872191450

To Catalin, Arnd:

At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
actively use and develop arm64/ilp32. I receive feedback / bugrepotrs
on ilp32 every 4-6 month. Is that enough for you to reconsider
including the project into the mainline?

For me, having different versions of ILP32 is more dangerous in this
situation, than upstreaming the project and fixing 2-3 bugs a year.

Thanks,
Yury
