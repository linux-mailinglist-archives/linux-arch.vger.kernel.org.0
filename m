Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561365F39C0
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJCXVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJCXVP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:21:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F027B32;
        Mon,  3 Oct 2022 16:20:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y136so11529102pfb.3;
        Mon, 03 Oct 2022 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=Q3+69+rJNNqDIBt2xxx5swC3PNGWjqGr+kUfHliTojg=;
        b=gvJIJRdB34Od+qxVq+481xrryySAtsmCHUeknglYR1vdHv2WTdCjhlD6Ehyw0rK7nK
         NvH6TKzGlkH9s7eN3i7nt/JrfgxAFpFN32wlF1OS43AYgHUROQINDHOq8bP3jbgTHz/+
         MqV1t+8eT+7O9/rrGsbajRZU3nZFOZXcM8tb9IACyz1kIEDNwbZ9namEl0541TE7J0ru
         3Ig6Z6wU6pxSb+EdsQU15kZZqZLRelVneiPKIc5au/rL3LvMhoFV3Z0T8SCqV5YMbuPm
         wBJiHe8NsM2zsEDAsFfLuNRkhokYuz7KVtvfzFIWjVvbVWOlHoLaIK8YXn33kolhElyo
         GY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q3+69+rJNNqDIBt2xxx5swC3PNGWjqGr+kUfHliTojg=;
        b=0Hic1+5h2wPD4CQJwBBDBV8WalAfHGaznqtiTHwJhIORhPNWJxoZOZiKYwqRqrJDhh
         T2CS5BmAp64kzYJea6aEXjpvOUZkxGyMzX0YN+nOL1dm7usvZpP5R05HT9VUNyCQP55H
         FcIneLUDRyuyD4gPec/vPi6OX8kdLtnNz6uS0/UgzIWzcOyUk8AiZTpUIDTyOyMvXLsZ
         OnZX6Du5WCPTKmlT9F9HhZFHZq/8ekcxk8dFLvs9qWq0bC8BLx6S2F4h7OTGyEWMOGS8
         1V//bXACHpMTjImlGdMlQvWh6sNC9BoKU6jO9+MVnrXoPuAWswRCH6SXLdYwAfsXnbt6
         5uPg==
X-Gm-Message-State: ACrzQf0Stwa7DDvcYzXINbrh6gXD1Km1eRTILvPEyWxtf+cOqcjpPWT6
        /NTk/bnBfCnB+BuHnk4d03k=
X-Google-Smtp-Source: AMsMyM4+Bl8P+EIRzxBRZhAs0nel50c7zZgGEkgDsjk3iTJpG+gQ2mArkGr5O1bby+RtdAE0jObniQ==
X-Received: by 2002:a63:fa42:0:b0:44d:b59c:674b with SMTP id g2-20020a63fa42000000b0044db59c674bmr7093475pgk.207.1664839257026;
        Mon, 03 Oct 2022 16:20:57 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id q12-20020a65624c000000b0043a1c0a0ab1sm7172916pgv.83.2022.10.03.16.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 16:20:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <35EEB9F0-D99A-4664-9628-27029B52CFD1@gmail.com>
Date:   Mon, 3 Oct 2022 16:20:53 -0700
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
Message-Id: <65CF3B29-BF53-4BA3-89D9-5398CEB7F813@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
 <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
 <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
 <35EEB9F0-D99A-4664-9628-27029B52CFD1@gmail.com>
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

On Oct 3, 2022, at 4:17 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Oct 3, 2022, at 3:28 PM, Edgecombe, Rick P =
<rick.p.edgecombe@intel.com> wrote:
>=20
>> On Mon, 2022-10-03 at 11:11 -0700, Nadav Amit wrote:
>>> Did you have a look at ptep_set_access_flags() and friends and
>>> checked they
>>> do not need to be changed too?=20
>>=20
>> ptep_set_access_flags() doesn't actually set any additional dirty =
bits
>> on x86, so I think it's ok.
>=20
> Are you sure about that? (lost my confidence today so I am hesitant).
>=20
> Looking on insert_pfn(), I see:
>=20
>                        entry =3D maybe_mkwrite(pte_mkdirty(entry), =
vma);
>                        if (ptep_set_access_flags(vma, addr, pte, =
entry, 1)) ...
>=20
> This appears to set the dirty bit while potentially leaving the =
write-bit
> clear. This is the scenario you want to avoid, no?

No. I am not paying attention. Ignore.

