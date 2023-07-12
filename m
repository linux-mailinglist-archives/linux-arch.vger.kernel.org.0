Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E3750F98
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjGLRX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjGLRX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 13:23:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4981410C7
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2023 10:23:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668704a5b5bso6466908b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2023 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689182636; x=1691774636;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tQ2ZbbyLLdcDDhvAxA5qEVgxy8o1H8UkklbLpk31ig=;
        b=hZjwQME8K62afCa/lKxAV5oDAQbtGEBFMc9MArh/PEz7oE9G6vUVAfOnb/9R4vBGxK
         1p1NcH+qnX13Ru4H4jouGvPcdhK1h6k+qCLXI8YVgtZPBu4W+jMhiqB+u/ZVxaEw0Hp6
         ihr02PgYKEWNMlwcQfr2/i7L4yiGRocd/mcHeDedHPSxJpwwaeiIvvgp1H7KSoPD7f+8
         o0jddnMArxfV1MgrK7mGxmRLv6ix4n+Nl1ki4KAFn1VZOXE1Fc/kMqnaq33dhWTBTKYY
         g2APClzhteWp3vYwyHS6lDvUJbrZdjwu2siZMPrkDOwHRcHeAF+ln9H611Ur9MnJmfCJ
         lZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689182636; x=1691774636;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tQ2ZbbyLLdcDDhvAxA5qEVgxy8o1H8UkklbLpk31ig=;
        b=THHkuCSl0w8AxSGe5eyd/A3rXEBe+ih02c583Vy/T8br2vZdfCV0MNqswOuLlYAScX
         OohCqbosthpbe1QKQaYfoDckHo5JnkLEHaT/xL18osN6zHn88MnhSYAKEGbQeEOUbaVS
         SOotKg5+N1jvUd+9BL+RAd9lRiOCEDs0yxp67kSimtCWDiRff/XOop+DgCEAZ6htUD5d
         WJvy26eaB+QKg+Hz7aaJuNLWvhn+k6Idp9STbrRVQHlQQrJBirHsE0XHF51CY4vKeAAb
         Zf037OtC0absXt+Ays+smfxGxmO/DTtLV8VMe4c9O5f82+jyu+adyaL6hIWD32VZ/eun
         C+zA==
X-Gm-Message-State: ABy/qLbad1aF9uYf2Uu396XQ/Tx9y9HpgSClOTxmZ6pVyz66MAXsEAu1
        58wzhmicMDCTzu4sAKzvMxlbSg==
X-Google-Smtp-Source: APBJJlGtz88dgA9P7FtTfAm49xR0+wVRjyt/ZcPAukIFsqkezm35JqgXO0FcyxCpfwYFDyT4jJgTMg==
X-Received: by 2002:a05:6a00:84d:b0:682:54b9:1093 with SMTP id q13-20020a056a00084d00b0068254b91093mr25574401pfk.15.1689182635685;
        Wed, 12 Jul 2023 10:23:55 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id ey24-20020a056a0038d800b00666add7f047sm3821151pfb.207.2023.07.12.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:23:55 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:23:55 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 10:23:08 PDT (-0700)
Subject:     Re: [PATCH 0/4] riscv: tlb flush improvements
In-Reply-To: <20230712-frying-unaired-e3acb5150e8b@spud>
CC:     alex@ghiti.fr, Conor Dooley <conor.dooley@microchip.com>,
        alexghiti@rivosinc.com, Will Deacon <will@kernel.org>,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, mchitale@ventanamicro.com,
        vincent.chen@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-c59b13d7-fec1-4203-87f0-be6ac124580e@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Jul 2023 10:19:47 PDT (-0700), Conor Dooley wrote:
> On Wed, Jul 12, 2023 at 05:18:00PM +0200, Alexandre Ghiti wrote:
>> On 12/07/2023 09:08, Conor Dooley wrote:
>> > On Tue, Jul 11, 2023 at 09:54:30AM +0200, Alexandre Ghiti wrote:
>> > > This series optimizes the tlb flushes on riscv which used to simply
>> > > flush the whole tlb whatever the size of the range to flush or the size
>> > > of the stride.
>> > > 
>> > > Patch 3 introduces a threshold that is microarchitecture specific and
>> > > will very likely be modified by vendors, not sure though which mechanism
>> > > we'll use to do that (dt? alternatives? vendor initialization code?).
>> 
>> 
>> @Conor any idea how to achieve this?
>
> It's in my queue of things to look at, just been prioritising the
> extension related stuff the last few days. Hopefully I'll have a chance
> to think about this tomorrow.. Famous last words probably.
>
>> > > Next steps would be to implement:
>> > > - svinval extension as Mayuresh did here [1]
>> > > - BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
>> > > - MMU_GATHER_RCU_TABLE_FREE
>> > > - MMU_GATHER_MERGE_VMAS
>> > > 
>> > > Any other idea welcome.
>> > > 
>> > > [1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale@ventanamicro.com/
>> > > 
>> > > Alexandre Ghiti (4):
>> > >    riscv: Improve flush_tlb()
>> > >    riscv: Improve flush_tlb_range() for hugetlb pages
>> > >    riscv: Make __flush_tlb_range() loop over pte instead of flushing the
>> > >      whole tlb
>> > The whole series does not build on nommu & this one adds a build warning
>> > for regular builds:
>> > +      1 ../arch/riscv/mm/tlbflush.c:32:15: warning: symbol 'tlb_flush_all_threshold' was not declared. Should it be static?
>> > 
>> > Cheers,
>> > Conor.
>> 
>> 
>> I'll fix the nommu build, sorry about that. Weird I missed this warning,
>> that's an LLVM build right? That variable will need to overwritten by the
>> vendors, so that should not be static (but it will depend on what solution
>> we implement).
>
> Just make it static until we actually have a vendor implementation of
> this stuff please, since we don't know what that will look like yet.

It's just a performance issue, right?  IIRC the SiFive errata wasn't 
actually based on how many TLB flushes happen, they're just broken in 
general so it was a probability thing.

If that's the case I agree we can just start with something arbitrary to 
start and then figure out how to set the tunable later.  It's probably 
going to be workload-specific too, so we'll probably end up with both a 
firmware default and a userspace override (maybe a sys entry or 
whatever).
