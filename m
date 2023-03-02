Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B06A79E9
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 04:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCBDR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 22:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCBDR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 22:17:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC85506D
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 19:17:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i5so14501964pla.2
        for <linux-arch@vger.kernel.org>; Wed, 01 Mar 2023 19:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1677727040;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On9It+4zdvXePGpqvCCrKF4Zz8YWrxnIbxTBVMgkuCs=;
        b=It4hmxTEAyg7hPQnG8xuSpgz+jJKrlOhrcoQbLU4P/YxhalWRyom0ZRJ9msu/DO/86
         AiIsktubYrvwpRFNifmG+BrBU8v6Yala4vW9pwjX/bv47kqdaFRBl58uJ5bIBRTWVMBT
         NEWSeyJD4fgG+iWneC8bOvtxcO0rBYIjkLBer1PgLGvr/r+TBMTp8+ncLKFkUa5GBOHq
         LyRA8ug4TwsdvYR3u1GIAGW60jHpBModJwHYh1E3SbElOIomsRGv1pXdHkKrQoLtx60j
         B+LSax1q+0/Z9R4mu/KI8ChOEX0yXbPBPiNHSvaszPAfYNONdpL5L3WAXmTh1suUklGm
         5kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677727040;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On9It+4zdvXePGpqvCCrKF4Zz8YWrxnIbxTBVMgkuCs=;
        b=OqpK6uorgDeLSmTuC8dYNzHCIpKPvYG3FbYCZJsIbwNCHYWocXpp0leFKOeyS635KZ
         8Q0ksnUeKTlaMfGcDUnr+AND+9tZkwt67NE2OOlpXgdgJx1BYz2tfr41/fQVwHfVe4c8
         v17/oebqIOf4sExrXicEbXfkOlgzxL8okbZ0g9XAhL3GDrEbpsv/rapA41yavrSgg7My
         AiaV1l73hX/UamlmbMHXihlzkkWqc+SRel5390fVyAQwOjdJuKttj5qVYUPn7XqFQJ75
         mMpbMoIN4olnI7SrJhc+88hyPfpcxfOEf+3oWYOxn72GYfI5SOxUYa0IHVbb+tvqgnd4
         Zdkg==
X-Gm-Message-State: AO0yUKXK0YQnKe1K82K6W/LDGWXmUcr1GlQT7/UfUFpw3WuizI3pmpyH
        NzUObc1LhT8qkkp37/5hYdsHVw==
X-Google-Smtp-Source: AK7set9NlkpYiMNjk7pdCtbLbxqSj79/p1ppAGwB6F9HvsUOQ5DEbSCAxLqrZ/Sx9hwWvoGz24uxIQ==
X-Received: by 2002:a17:90b:1c8d:b0:236:76cb:99d2 with SMTP id oo13-20020a17090b1c8d00b0023676cb99d2mr10274539pjb.8.1677727039843;
        Wed, 01 Mar 2023 19:17:19 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a498700b002340b2c62e7sm437605pjh.55.2023.03.01.19.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:17:18 -0800 (PST)
Date:   Wed, 01 Mar 2023 19:17:18 -0800 (PST)
X-Google-Original-Date: Wed, 01 Mar 2023 19:04:58 PST (-0800)
Subject:     Re: [PATCH v3 00/24] Remove COMMAND_LINE_SIZE from uapi
In-Reply-To: <Y+tSBlSsQBQF/Ro2@osiris>
CC:     geert@linux-m68k.org, alexghiti@rivosinc.com, corbet@lwn.net,
        Richard Henderson <richard.henderson@linaro.org>,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, chenhuacai@kernel.org,
        kernel@xen0n.name, monstr@monstr.eu, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chris@zankel.net, jcmvbkbc@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hca@linux.ibm.com
Message-ID: <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 14 Feb 2023 01:19:02 PST (-0800), hca@linux.ibm.com wrote:
> On Tue, Feb 14, 2023 at 09:58:17AM +0100, Geert Uytterhoeven wrote:
>> Hi Heiko,
>>
>> On Tue, Feb 14, 2023 at 9:39 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>> > On Tue, Feb 14, 2023 at 08:49:01AM +0100, Alexandre Ghiti wrote:
>> > > This all came up in the context of increasing COMMAND_LINE_SIZE in the
>> > > RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
>> > > maximum length of /proc/cmdline and userspace could staticly rely on
>> > > that to be correct.
>> > >
>> > > Usually I wouldn't mess around with changing this sort of thing, but
>> > > PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
>> > > to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
>> > > increasing, but they're from before the UAPI split so I'm not quite sure
>> > > what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
>> > > asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
>> > > boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
>> > > and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>> > > asm-generic/setup.h.").
>> > >
>> > > It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
>> > > part of the uapi to begin with, and userspace should be able to handle
>> > > /proc/cmdline of whatever length it turns out to be.  I don't see any
>> > > references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
>> > > search, but that's not really enough to consider it unused on my end.
>> > >
>> > > The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
>> > > shouldn't be part of uapi, so this now touches all the ports.  I've
>> > > tried to split this all out and leave it bisectable, but I haven't
>> > > tested it all that aggressively.
>> >
>> > Just to confirm this assumption a bit more: that's actually the same
>> > conclusion that we ended up with when commit 3da0243f906a ("s390: make
>> > command line configurable") went upstream.

Thanks, I guess I'd missed that one.  At some point I think there was 
some discussion of making this a Kconfig for everyone, which seems 
reasonable to me -- our use case for this being extended is syzkaller, 
but we're sort of just picking a value that's big enough for now and 
running with it.

Probably best to get it out of uapi first, though, as that way at least 
it's clear that it's not uABI.

>> Commit 622021cd6c560ce7 ("s390: make command line configurable"),
>> I assume?
>
> Yes, sorry for that. I got distracted while writing and used the wrong
> branch to look this up.

Alex: Probably worth adding that to the list in the cover letter as it 
looks like you were planning on a v4 anyway (which I guess you now have 
to do, given that I just added the issue to RISC-V).
