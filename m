Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C032F738E00
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 20:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFUSCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFUSCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 14:02:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A129D;
        Wed, 21 Jun 2023 11:02:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25e7fe2fbc9so3037079a91.2;
        Wed, 21 Jun 2023 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370539; x=1689962539;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghR3ONQ0xCWF/XsVVqlYhvKkezqnfnGRVsn4IWmNqPA=;
        b=WlDhY0OAVtt9U/sOOElyyyzC8WQUo6poFN2oaUUbgXb/+d/IcLxLnp/l+UzGUwpnTP
         qNVRgaSawr/Lks/MVqkXW3vhZ6kxmceUTjHXM6jlyF1GptNr1dqW3DS3mHch/GovOfRj
         eeIG+2GeD7qLThk604Ls1Dm6ulCuVqsz3HJeNzmw20ui3f1km/wN1Lsn8new91sCB9f4
         Y/9gdFH2EtmVLBvhgPnz+wuC+/IaW12lqMa1hMv5oCDcKrdyydt7o/GSHiNNyTmCgyjE
         n6f4GEOsh48n3nZWOX6uYilALlQZViylNfVYvHM7mBlUYr3PiCQJ7ZWpUMc3s5dLxZUE
         OjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370539; x=1689962539;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghR3ONQ0xCWF/XsVVqlYhvKkezqnfnGRVsn4IWmNqPA=;
        b=kSlWNIkwNJ5KFt1U5a7Vv6vUphbCVfgkll3XXjmbASforS54EYcu2dO+RtQD1MTAbz
         IV9JlQoZWOeDPKpCqJ/ssggXgUNpjufXJ1lOx+wQure1Z/qRh4VTncNmqElz0ok6fCyu
         puI49LTDbVEKaw+uXmC6jIanMi9bV0hKg2znzPSTSssWg1lfdi8lb37TanBkSvCLU5HL
         hzM2/b/wxN36/GFRiW0gkdq+v/B8meRIv692is0FpZArKWjTWEOWRGsx9u72EEcfSRjy
         0l/ypA8RfSDQPeN/XD9EVzIoBv0k4fMOSeCi8ryiwl7x+oWVn4KrTKA4ifKV9iT1toZC
         SpUg==
X-Gm-Message-State: AC+VfDyJlWGbFxmDiTOlxGEzHOOb4gABL74oNTD39MgKuS/5WNAKdm9Y
        5ZLphXyB6Nn21HG0dGxn6VI=
X-Google-Smtp-Source: ACHHUZ6mRoAo2s2oCkgP3Wp2nUTJXsXUGVHNcWUvqJUw9GFNXu1TCgqL3BU4dWywAqRpkfH2O6TdSg==
X-Received: by 2002:a17:90b:4c8d:b0:25e:a5b2:8463 with SMTP id my13-20020a17090b4c8d00b0025ea5b28463mr11111864pjb.8.1687370539354;
        Wed, 21 Jun 2023 11:02:19 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r10-20020a638f4a000000b005439aaf0301sm3329045pgn.64.2023.06.21.11.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2023 11:02:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to MM CPUs
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230620144618.125703-3-ypodemsk@redhat.com>
Date:   Wed, 21 Jun 2023 11:02:05 -0700
Cc:     mtosatti@redhat.com, ppandit@redhat.com,
        David Hildenbrand <david@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        svens@linux.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        Arnd Bergmann <arnd@arndb.de>, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, linus.walleij@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        sebastian.reichel@collabora.com, Mike Rapoport <rppt@kernel.org>,
        aneesh.kumar@linux.ibm.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10050BB1-15A4-4E84-B900-B21500B2079B@gmail.com>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
 <20230620144618.125703-3-ypodemsk@redhat.com>
To:     Yair Podemsky <ypodemsk@redhat.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>=20
> On Jun 20, 2023, at 7:46 AM, Yair Podemsky <ypodemsk@redhat.com> =
wrote:
>=20
> @@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct =
mm_struct *mm, struct vm_area_struct *v
> 				addr + HPAGE_PMD_SIZE);
> 	mmu_notifier_invalidate_range_start(&range);
> 	pmd =3D pmdp_collapse_flush(vma, addr, pmdp);
> -	tlb_remove_table_sync_one();
> +	tlb_remove_table_sync_one(mm);

Can=E2=80=99t pmdp_collapse_flush() have one additional argument =
=E2=80=9Cfreed_tables=E2=80=9D
that it would propagate, for instance on x86 to flush_tlb_mm_range() ?
Then you would not need tlb_remove_table_sync_one() to issue an =
additional
IPI, no?

It just seems that you might still have 2 IPIs in many cases instead of
one, and unless I am missing something, I don=E2=80=99t see why.

