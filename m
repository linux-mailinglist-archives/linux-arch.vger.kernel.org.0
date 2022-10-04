Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E147D5F3AC1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJDAkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 20:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDAki (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 20:40:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FA2AC73;
        Mon,  3 Oct 2022 17:40:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16907710pjq.3;
        Mon, 03 Oct 2022 17:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=+/Mka7TP1STCGf7CSP8aOzP/j3ypJV5FS9jSff6Kndw=;
        b=pqGdfqbWYJvqI2Of+PeOx1WBv1PrdAmEktEt7KtFjMrkdmsQC2jJJ4M8vwN1VzfOC/
         cJJbBHE6qti1z5u6bdoOqHQoT3YaUiozafzRvBx+uOVs+FEl3qJcdMnNCeeoLV8gIgff
         GJjNkTGx9eG2X0YsJzb+B5nmJIHSHB7MYnI3XMTIVBzMFilMBSCTBGYSP0GirTgQ72Bl
         sh++kqoZKYfpQepDCFQHl6FJ8WLD49clt5FXCIwPVk4bMiDiYsCfPPFDISO6Sq8xBxtS
         peDXEHcnp0mmAzaIfMx9s1sh1KTB27TXbSIun9uHTiFK9aDcdWIkJtybIe5iYgve+/6F
         RclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+/Mka7TP1STCGf7CSP8aOzP/j3ypJV5FS9jSff6Kndw=;
        b=4QkSS2rNbphzkNJhy2m8HWQOowZJnc6mLWzw3dMCxm5UQQljBpBoAD1hBIq2So/Ff+
         uDkX+L8O4jo6Wrldm98S9VCWoQgRNiBwXg0odgV7cfoa46LoAIfBRMS7ysPTk7e1Hds3
         lFl4OC+/8J9MGRmADrBXm8DL9Br2eXBb+e2d0czBMA+HabaambDXwE9Yp1nw+RUmGSrl
         Ysd2ff9AZHyp1lUTY8mnmD8nZhm30aKtbJBgTIQN9bhm8TVXrhKCJI1J9pTiLL4eUDHW
         DSQ0bigJWM3KHU7LSlT+ag/TQaea5dPADlkJLy+ZDpbPp/L0t2Ob1v5QQ+115O/Touel
         tbhQ==
X-Gm-Message-State: ACrzQf1G6mNSey5OptafjdzFUoY8m7SodF90yZt0KLlEjki+YK6xu2km
        Tv6kZWSJ1kpIGzJZCqDfeGI=
X-Google-Smtp-Source: AMsMyM4oB1eZrAcM5PukmrfyczOXgACQAqwlz9k+nfojTYnOGZfABmctQC9QWv7CCvUhblpu0GSnfA==
X-Received: by 2002:a17:902:d48d:b0:178:306d:f75c with SMTP id c13-20020a170902d48d00b00178306df75cmr24637584plg.73.1664844036518;
        Mon, 03 Oct 2022 17:40:36 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id c202-20020a624ed3000000b005616fd75a22sm2855137pfb.112.2022.10.03.17.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:40:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <547f2a8a87c255c58dbf2350013f72649dfcdc10.camel@intel.com>
Date:   Mon, 3 Oct 2022 17:40:33 -0700
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF99C63D-670D-40B4-98DC-22E9F416244E@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
 <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
 <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
 <35EEB9F0-D99A-4664-9628-27029B52CFD1@gmail.com>
 <65CF3B29-BF53-4BA3-89D9-5398CEB7F813@gmail.com>
 <FF5CBF3F-A66F-4923-BEAC-D1C95DAB740D@gmail.com>
 <547f2a8a87c255c58dbf2350013f72649dfcdc10.camel@intel.com>
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

On Oct 3, 2022, at 4:38 PM, Edgecombe, Rick P =
<rick.p.edgecombe@intel.com> wrote:

> I think the HW dirty bit will not be set here. How it works is,
> pte_mkdirty() will not actually set the HW dirty bit, but instead the
> software COW bit. Here is the relevant snippet:
>=20
> static inline pte_t pte_mkdirty(pte_t pte)
> {
> 	pteval_t dirty =3D _PAGE_DIRTY;
>=20
> 	/* Avoid creating Dirty=3D1,Write=3D0 PTEs */
> 	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
> 		dirty =3D _PAGE_COW;
>=20
> 	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
> }
>=20
> So for a !VM_WRITE vma, you end up with Write=3D0,Cow=3D1 PTE passed
> into ptep_set_access_flags(). Does it make sense?

Thanks for your patience with me. I should have read the series in =
order.

