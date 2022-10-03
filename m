Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C745F39CE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJCXZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJCXZf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:25:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F72A968;
        Mon,  3 Oct 2022 16:25:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b15so3193979pje.1;
        Mon, 03 Oct 2022 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=DmfOOdFXaL0JuSZU4cVh2580j6bx6ldhnISbfDNKWOE=;
        b=JCoc10EhxH6q5Pv4YB6gRBxx31cIlAWCF/wq1sohlxRLphWQMhux2X6tV93TBWsYx/
         nSS8GwejbkeGbmbCkxk5nvufaMXoG5RNVW6s75l9qtqW0SDt+HYIZIAkBENvgQxdd8Il
         bf2cKL8XLSds30n/koPCIeQRxgWnl+2+1siNHrxqoW2J2qaI6IkKdRp7tTuKLmp5GqSt
         hHDO38kuyJSmWT6uYqQFoA6gmAmtv1RDpK0lzIALr0h/dl505ZeALUcHqOUJdTa8dfuT
         ICsx0Bidpud/KEWwp2l4IGFJi6IiRxgVyiG8iwtXbWu5MXktVYfpS4uzlUi4W4jBZvZT
         Dr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DmfOOdFXaL0JuSZU4cVh2580j6bx6ldhnISbfDNKWOE=;
        b=Kvyihu1bue0WWR0oW7wvdFzA1t68CzK5yNQARJ1JfblW08Pkh5it5XlhJZFB8OuQdt
         +82uF5jz6m+/gJNqoTr9UDSJ0Uz2OpVUbaXtHVOXao+BE+13uKk+jQr1BGQPdUOddDKD
         tch7MHCR6IGy+UkSi+8qIyDMqHk/HJOuYnaHFtv90ZJOlOP0gmXVVUjmvxDIYQ0wr7Lo
         egi+FCr5OBSt+tiYSvZ57cyHVA9djIb6bX1Nac+eR6WNnvtZe5GNHUXAKMD3hZS9ejQG
         bee9etnQKh9jwimWaSHFgd08DGqt9bD11T30s7zzY67NUID2TnfV3xuZTmYZLy5jOMPG
         5BhA==
X-Gm-Message-State: ACrzQf3mFR5HO4S67n/htFC/PDLsIw5pjs/lZIqKwXawWnoMxleZP4Cx
        s9lv+Z9hDXNbFax94xyUnz8=
X-Google-Smtp-Source: AMsMyM62A56VKYbCq0UI78bHnq7ee99Wsp4u+3B2txH6wZFNKxJIm/OP7KT2KVSiusLB/emV6CFkoA==
X-Received: by 2002:a17:902:c952:b0:176:bb2c:5459 with SMTP id i18-20020a170902c95200b00176bb2c5459mr23390032pla.165.1664839533934;
        Mon, 03 Oct 2022 16:25:33 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090ad38f00b00209a12b3879sm6848904pju.37.2022.10.03.16.25.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 16:25:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <65CF3B29-BF53-4BA3-89D9-5398CEB7F813@gmail.com>
Date:   Mon, 3 Oct 2022 16:25:27 -0700
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
Message-Id: <FF5CBF3F-A66F-4923-BEAC-D1C95DAB740D@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
 <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
 <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
 <35EEB9F0-D99A-4664-9628-27029B52CFD1@gmail.com>
 <65CF3B29-BF53-4BA3-89D9-5398CEB7F813@gmail.com>
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

On Oct 3, 2022, at 4:20 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Oct 3, 2022, at 4:17 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> On Oct 3, 2022, at 3:28 PM, Edgecombe, Rick P =
<rick.p.edgecombe@intel.com> wrote:
>>=20
>>> On Mon, 2022-10-03 at 11:11 -0700, Nadav Amit wrote:
>>>> Did you have a look at ptep_set_access_flags() and friends and
>>>> checked they
>>>> do not need to be changed too?=20
>>>=20
>>> ptep_set_access_flags() doesn't actually set any additional dirty =
bits
>>> on x86, so I think it's ok.
>>=20
>> Are you sure about that? (lost my confidence today so I am hesitant).
>>=20
>> Looking on insert_pfn(), I see:
>>=20
>>                       entry =3D maybe_mkwrite(pte_mkdirty(entry), =
vma);
>>                       if (ptep_set_access_flags(vma, addr, pte, =
entry, 1)) ...
>>=20
>> This appears to set the dirty bit while potentially leaving the =
write-bit
>> clear. This is the scenario you want to avoid, no?
>=20
> No. I am not paying attention. Ignore.

Sorry for the spam. Just this =E2=80=9Cdirty=E2=80=9D argument is =
confusing. This indeed
seems like a flow that can set the dirty bit. I think.

