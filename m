Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D955F39B3
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJCXR6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJCXR4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:17:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C438BDD2;
        Mon,  3 Oct 2022 16:17:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a23so3290651pgi.10;
        Mon, 03 Oct 2022 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=cF6w9w5X7amibS6REZNPvQpkz6hVdgXqlpPTRgjKOOU=;
        b=EdhdDGXccvWvAcdeD8lKaCH9Qlu8RC1doJmdQv10fYLzDxDnFHinxgTu7ZVp3hSxnx
         2dfOgLm/ifEfE7tWxOlAl5GKBKeSKuZYvVc0MpBJhfSzkBDd0GG5yWXzPHFIoe7Acnvt
         7ffe9OYuua1fSTX7G+l97pE2EqOcGDcxfn2KQYiOKfrSwJJhnHYBBJuHHie335oLn9Bt
         m+YUFW7HRp/FgJISMk4C0UQUCSOq2do0gLRgqQnOHO6z7b6J+zwizQJXckKIiLwzwJ3w
         UWAG3ka0c3bn9FIFyYNJvkAr6T2/b99u3MwyQy9UlPFZ7rWJKQ2335FNc8tZb0UZ2jLD
         i5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cF6w9w5X7amibS6REZNPvQpkz6hVdgXqlpPTRgjKOOU=;
        b=uH8c6Cq/ZPtzkaPcSrPWJc3FBHRh5nzvNAhYRhX1TmzMsNT1H/tB7bM1AGm4X1kDOB
         VH55XoX8eIB8RW83ME9e68YxFfwMPuwgrEUvy8tN0E4y7ZLmBHz2+BhALvHUDz5QYcE6
         h8wJKTRxjykGYNn7tuT1U1ke18TeMn+LypOocCapg5hEQVcCTsrhCDiEjBnJVW9tXbP4
         41qO5kC9XOLv27gERSotmf7/CF0mNyzwKGwnpzJ45K7rp5xRkeo+i7aOagbZURa7xFqh
         ZPPNja0xQs9IkcCWHJU+m/yu3mwHWm3tKuFQMH3dfkXOtGNJ2m2YAzkUC58bmOO9jNyW
         WCqw==
X-Gm-Message-State: ACrzQf22bkLGCK+DsKZgLoXER2DpQGRBZ3+joioUgpFK0NHpeSoEzdl0
        L+nfgY8MA2yPsCOAsCT+oCo=
X-Google-Smtp-Source: AMsMyM4n/AJvFE/d3TYFJJYJ4un/v9u7OCLnjbu3wozi/xsNx3IhRWyZCu0U8G5vBhH2rNE3kNGwNQ==
X-Received: by 2002:a62:8342:0:b0:560:fea3:f45e with SMTP id h63-20020a628342000000b00560fea3f45emr9606455pfe.45.1664839075037;
        Mon, 03 Oct 2022 16:17:55 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016c5306917fsm7825144plg.53.2022.10.03.16.17.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 16:17:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
Date:   Mon, 3 Oct 2022 16:17:51 -0700
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35EEB9F0-D99A-4664-9628-27029B52CFD1@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
 <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
 <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Oct 3, 2022, at 3:28 PM, Edgecombe, Rick P =
<rick.p.edgecombe@intel.com> wrote:

> On Mon, 2022-10-03 at 11:11 -0700, Nadav Amit wrote:
>> Did you have a look at ptep_set_access_flags() and friends and
>> checked they
>> do not need to be changed too?=20
>=20
> ptep_set_access_flags() doesn't actually set any additional dirty bits
> on x86, so I think it's ok.

Are you sure about that? (lost my confidence today so I am hesitant).

Looking on insert_pfn(), I see:

                        entry =3D maybe_mkwrite(pte_mkdirty(entry), =
vma);
                        if (ptep_set_access_flags(vma, addr, pte, entry, =
1)) ...

This appears to set the dirty bit while potentially leaving the =
write-bit
clear. This is the scenario you want to avoid, no?

>> Perhaps you should at least add some
>> assertion just to ensure nothing breaks.
>=20
> You mean in ptep_set_access_flags()? I think some assertions would be
> really great, I'm just not sure where.

Yes, on x86=E2=80=99s version of the function.

