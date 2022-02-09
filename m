Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95EA4AF392
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 15:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiBIODS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 09:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiBIODR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 09:03:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B25C05CB8A
        for <linux-arch@vger.kernel.org>; Wed,  9 Feb 2022 06:03:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id u20so3331944ejx.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Feb 2022 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BowBxy6mujSqc6uDobbJd7gE25OPxJU1WR17zdO/EU8=;
        b=BXnsEfJhH0VLxc5l2+6yzTne2H+dAodEaOC7t90ck3dpcoApPfZeQw7ERDf+TMvabO
         AUyVjsh3w42IINu4lpfyKxBDJj3jGQvXewZmm44/nrdDsSeTfbPuHkyjuA8aQeIXRWbk
         YK+eKcMdcjqMdMa6tkUG1S8Qc5dyd/HPpdN9FCiXCyW57o+tCruGQP9LRNbyPgifd7xn
         Ovggwhv3jOMErW0rCok/7mdoeeLcz6Al/7fi2fKl5pBbuXO9VJU1qTvelWvzrjNQ9ZWx
         8dD9LOJXOmqYJjPbjK/VtTNpdPiq/ITP6K5IY2YaSXSiZOU2ZmlvYyr2WgV5Bt60uxvI
         vyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BowBxy6mujSqc6uDobbJd7gE25OPxJU1WR17zdO/EU8=;
        b=QAnMfPOfIlV+hSj4L26c6wFSv3RxSoAqWBfY/DXC2Lpx92Y2itOY2s1Jdkor98JyUD
         Cy8JQkRURv9q1kcfJcMlxNbR3+HjCZH3nrajLPFKqoLgXSKNJevlp3pBhuAk05E0O9xf
         Gm2G+N8Y69oDxF+/j4E9BK07oV5NbrvxAKtVPk1RyDCA7bIOt7wafRcF1P/Y9+DWm3lJ
         o4JHq4yHmdNzruJ1MXr9two3v1kmSJIo/cumESb/Z4aK2BeCrWWQe7EmWZGKcqy0ZX5l
         SafAxFbOsUetcV5J+DuW5BbA6Th4ZvXs62W8VWt+Jj5HgVeVLIXoHp95lGQ7DY361Vuj
         NUVw==
X-Gm-Message-State: AOAM5332HwHbCuyLeUSfmxeRjbRB2lCEns2031VjxKTyaZC4ybUoW44m
        n/HWIzCHE5JpAOGbMDcEadkH9Q==
X-Google-Smtp-Source: ABdhPJx8GIenK2WVSAEcQAHLIXwXIN1cxrvW0M5u13kIK1XJWen2Q0kfxVwPnlgU4k0e5go3yIU2CA==
X-Received: by 2002:a17:907:c0d:: with SMTP id ga13mr2122813ejc.576.1644415398689;
        Wed, 09 Feb 2022 06:03:18 -0800 (PST)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id d10sm3488487ejb.22.2022.02.09.06.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:03:18 -0800 (PST)
Message-ID: <97825798-4071-6fef-ae87-e448e823d737@monstr.eu>
Date:   Wed, 9 Feb 2022 15:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <YgPHJy9NDVFr5s6w@infradead.org>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <YgPHJy9NDVFr5s6w@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/9/22 14:52, Christoph Hellwig wrote:
> On Wed, Feb 09, 2022 at 02:50:32PM +0100, Michal Simek wrote:
>> I can't see any issue with the patch when I run it on real HW.
>> Tested-by: Michal Simek <michal.simek@xilinx.com>
>>
>> Christoph: Is there any recommended test suite which I should run?
> 
> No.  For architectures that already didn't use set_fs internally
> there is nothing specific to test.  Running some perf or backtrace
> tests might be useful to check if the non-faulting kernel helpers
> work properly.

Thanks for confirmation. Once Arnd sent v2 with updated commit message I will 
queue it to next release.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

