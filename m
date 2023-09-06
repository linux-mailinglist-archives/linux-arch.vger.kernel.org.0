Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA1279446F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbjIFUWb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjIFUWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 16:22:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763C19A6;
        Wed,  6 Sep 2023 13:22:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-573ccec985dso204691a12.2;
        Wed, 06 Sep 2023 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694031747; x=1694636547; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD7kjBc/iBCRToogLtJPKs8deknmulxtzUCmXzFwU6E=;
        b=HcefUdvXO2pWWelKoKq0NjZT/pamrQqbYQyQmvr7ScwFqJXQuuATr44LcLacvN8xi4
         /g8qpMZPFI+t1+so1c3bJo9JKgdiekpvO/Ztwomh2JXAOKMe8e1UJNiNcJmISHwLxoJ1
         +5Tl+tGfZsYbuWqJhoIXG/fpEHOFSNTYfUCHaBDL9ClaWqTmgfxv46DSB6UET+kPq4Y0
         xCl8TLS5HNSJmtID9gsvdLvxLC2So+f0vgzgYnSoC6C2t1FBguFqrf9ZvB8jcbyfHJAX
         abo5AWGgewK10kqgoIoyImvXzUmfaMP1QzaJyllyFhTMq6TybsJG7hCY7E84yAp31PT+
         aIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031747; x=1694636547;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD7kjBc/iBCRToogLtJPKs8deknmulxtzUCmXzFwU6E=;
        b=AKd65SGymrIWw/rwX/GWqvuh4XfcV4/h3J9AGfVlia6ZMHJVMt86nBEJSUnqNJWUwH
         NpcjV65Ft6ocIYY4ylm4bqtS/1aF/pOK48hBiTFdBDr7k6TgB3G3bdRWY4r+FiR3qxn+
         ftq7ove0oYPAQtbIiw1BmaUqO6A6ja9rx3S9cqasFxLNb+SKPxeVrxuYy43jUV6Wr9EN
         X4qvPE/qQdjqwu/qA6rgOADXrCL31ios8BPZfsWhGUMia/Ub8xIy0Lq4xL6LG/3jGB1u
         RTqYsTt443bLWv0sV3HDI10omg9+POEwvHKlvNYjpT3SSzL9ZZTbaW/hQQPhG7Xj+yKA
         Jc3w==
X-Gm-Message-State: AOJu0YybMyGojlCUK5Ls1unsleFdrvXeWpghteBDJasg1pY5+gPEdeng
        LcU+TS34zHytnFMKLjnV8oY=
X-Google-Smtp-Source: AGHT+IGmvOVV/7HqCSH46swl/UmrMsBdSsMfSDMwiGwNRsu0ygeNZKfizRBSj3U2w7qfL3CnxZ0o2w==
X-Received: by 2002:a17:90b:212:b0:271:ae19:c608 with SMTP id fy18-20020a17090b021200b00271ae19c608mr15956217pjb.41.1694031746571;
        Wed, 06 Sep 2023 13:22:26 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090ae99700b00256a4d59bfasm169219pjy.23.2023.09.06.13.22.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Sep 2023 13:22:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
Date:   Wed, 6 Sep 2023 13:22:13 -0700
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C92430BE-4DA3-487B-BFD2-58EE4A93396F@gmail.com>
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com>
 <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Sep 6, 2023, at 4:48 AM, Lad, Prabhakar =
<prabhakar.csengg@gmail.com> wrote:
>=20
> Hi Alexandre,
>=20
> On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>=20
>> This function used to simply flush the whole tlb of all harts, be =
more
>> subtile and try to only flush the range.
>>=20
>> The problem is that we can only use PAGE_SIZE as stride since we =
don't know
>> the size of the underlying mapping and then this function will be =
improved
>> only if the size of the region to flush is < threshold * PAGE_SIZE.
>>=20
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>> arch/riscv/include/asm/tlbflush.h | 11 +++++-----
>> arch/riscv/mm/tlbflush.c          | 34 =
+++++++++++++++++++++++--------
>> 2 files changed, 31 insertions(+), 14 deletions(-)
>>=20
> After applying this patch, I am seeing module load issues on RZ/Five
> (complete log [0]). I am testing defconfig + [1] (rz/five related
> configs).
>=20
> Any pointers on what could be an issue here?

None of my business, but looking at your code, it seems that you do not =
memory
barrier before reading mm_cpumask() in __flush_tlb_range(). I believe =
you
would want to synchronize __flush_tlb_range with switch_mm() similarly =
to the
way it is done in x86.

