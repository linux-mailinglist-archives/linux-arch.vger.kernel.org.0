Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBBA5F0EA6
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiI3PRJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiI3PQ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 11:16:56 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16A157BA4
        for <linux-arch@vger.kernel.org>; Fri, 30 Sep 2022 08:16:50 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z191so3495615iof.10
        for <linux-arch@vger.kernel.org>; Fri, 30 Sep 2022 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rav/GnxDxXCmb0MWmQJI5rI/wm0ZOCSwNoHHz9z+r7A=;
        b=YB6CjrLNYng7WeQ+wslm2VPbitaNP0ShR1T5EE1nM1ZDzkPIUIob+C5C13QD3JXPF1
         NlTKpUe1scku9p9XtGg1Izf8Dc1TpUfDODtn3jM3q+jUgY+zDC8CkVafqeyuUs5Ukq4H
         mxgGAAK+DsgqM6tuU2p8NgFuDB9wt0vJRVLYwkBPKv4B/ePv4XSF+IhrLjGkmdoqQgiK
         rxRERHXXtZc2phGR1txS5Ern3RsbTR4MwgYbmiOu6gqswdwU6HISzy3r1yVdTddsuKrM
         iiaVoLmXP/g0d+Kep6mJQOi0gGm+i42CSw87iKLR+VGAZR0m1PHT3JTUY1Mdx8cOHtjv
         UphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rav/GnxDxXCmb0MWmQJI5rI/wm0ZOCSwNoHHz9z+r7A=;
        b=qdjmzZ7GYvLtYmFq0bnKUW3bqXZMRvrYv7gjKLSqvWd0PR8fhYuh10VifyCJW9Ccu7
         BkE5hvbciXDuVdtOVNMsTr6zzQb+B5OytULLNAojoHqm/jBvfWNJqzrDERa0yFHqy/xp
         AerPz9+EzHni+d2AMHmrsf3ceQoh0r8JR4nqHE2rhlIuYLNm+vsRuVqIMZAbcR6AAYZm
         wZwxdMHpRb/jYm5LrnHmqPkJdY74GzLTQCZspcTKHpObez1ZRLDBo4yEseYIr/qIqn1G
         uTcQblIvMvDfpQMEX1LAlVs/2FNzk/qfySxClJRsi8kt01bdiJq0SS0XoaMmD+zEleMF
         c5uQ==
X-Gm-Message-State: ACrzQf09/CTbxqTOY1HDx2BObhXWJupsZr/jgL+anSvTnwwq8LCj4GuE
        dRGB/64LXwHpBknU4j3Cjl9mEORrAey0FabtfsHTqA==
X-Google-Smtp-Source: AMsMyM6F7AAgEnbDB3rrGofw7Np/IRuyPPKXtazfBLnfUtfrHBecx6ZQ4/DCYfPtN9Dyv/lb8mRBcckQ17dphsFV0xw=
X-Received: by 2002:a05:6638:31c2:b0:35a:c5b1:b567 with SMTP id
 n2-20020a05663831c200b0035ac5b1b567mr4600630jav.58.1664551009140; Fri, 30 Sep
 2022 08:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com> <20220929222936.14584-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Sep 2022 17:16:12 +0200
Message-ID: <CAG48ez3hXfsUkMqcHmVetzywKC8a+PLhGReceTdwCf7B03Oj7g@mail.gmail.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 30, 2022 at 12:30 AM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> The reason it's lightly used is that Dirty=1 is normally set _before_ a
> write. A write with a Write=0 PTE would typically only generate a fault,
> not set Dirty=1. Hardware can (rarely) both set Write=1 *and* generate the
> fault, resulting in a Dirty=0,Write=1 PTE. Hardware which supports shadow
> stacks will no longer exhibit this oddity.

Stupid question, since I just recently learned that IOMMUv2 is a
thing: I assume this also holds for IOMMUs that implement IOMMUv2/SVA,
where the IOMMU directly walks the userspace page tables, and not just
for the CPU core?
