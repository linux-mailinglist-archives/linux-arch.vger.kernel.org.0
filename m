Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE86BEF27
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCQRGE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCQRFv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 13:05:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E13BC6F
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 10:05:29 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id cj14so6427205ybb.12
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679072728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8pw8ANjC03MPGK7KX+jv/0782fAZ5TNseS9cfoKjGg=;
        b=pP5A+izrLpH07QymScG4K0Q3RviucyHodZbuurWnbqgGs2l1xnUwo1+rbiuh8HFsah
         piqiQJlAN+H5zgY2WxLTZUo/9QQHUXh1fQ8fkIDsmjBFjPbgj9csybuw3J1L9nJ/ABi2
         bFL5HkeGlW6PAwFgupg0pDB08xpPMBGgJAHN+m8IwU/ztiydhNiNFfYurnrwyAOno9a4
         Ujb8IACLqfDadtIwc+YU/TBIHXect4WadFxISSTKwMnlSxrq2hhm2qlA1wjrVqf162//
         5j9vaTz0UNhHxR8M9TINFZJ7p4TkddhzKVSme3hBv4/lvcBPrlxD/Sob7G6k8WSKQlr4
         lvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679072728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8pw8ANjC03MPGK7KX+jv/0782fAZ5TNseS9cfoKjGg=;
        b=cqU/AA8cfOMtA0/YAzZ5t4JmK03D1xRV9kOXkR/678cinIhxGyWQr3uxWkwwUoxBrQ
         iyYZ9/6qK3zZmeMzm8rud70+lFPlvO32557NcXz5MQaaQikjNfChskK5UFwsjss24bcu
         cRFRpzKpOSI0wKhq03uh/5S5xwbrW2X2rb8/P83hfu+EzpjmVxzIOMVNcOcAQFb2FKUI
         YeMJRWDlXMQt2ySky3qswTUao+RNbZl67YhAbyYEaZsZkTR+8VnuQPL4Jwe6irX0AmI3
         M0rmdwn600i+QiVyt+Yh1OabPQpdjioVzQGO3m9zIAEGS8jxMuneNwa0I+KyTkaQIBJE
         qy7A==
X-Gm-Message-State: AO0yUKX+g7HA3AUxw+hoA6LoJLaKyKn7KF+zh32x2atxx535vUwke99a
        Y6VwZo6Ra8UnFAv0iA/tNPTLBNDE8E07x39eQK3IXw==
X-Google-Smtp-Source: AK7set+D8OFVbAtEyZV0DNRmF/56fcde9ah8LpollyTgt+UHbDfOUt8Zr0yeZMQQArbAGbw+RPWEeXZ7zZLCT8vnPLs=
X-Received: by 2002:a05:6902:85:b0:a6f:9156:5579 with SMTP id
 h5-20020a056902008500b00a6f91565579mr138099ybs.12.1679072728330; Fri, 17 Mar
 2023 10:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com> <20230227222957.24501-25-rick.p.edgecombe@intel.com>
In-Reply-To: <20230227222957.24501-25-rick.p.edgecombe@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Fri, 17 Mar 2023 10:05:19 -0700
Message-ID: <CAKC1njRh8zz9jUM3xwCeZ1hs9K8o=mF8VKTsYyG73a5tTe4FkA@mail.gmail.com>
Subject: Re: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack memory
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 2:31=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index eab18ba045db..e7c7bcc0e268 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -978,7 +978,7 @@ static int check_vma_flags(struct vm_area_struct *vma=
, unsigned long gup_flags)
>                 return -EFAULT;
>
>         if (write) {
> -               if (!(vm_flags & VM_WRITE)) {
> +               if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK=
)) {

I think I missed this in the review.
`VM_SHADOW_STACK` is an x86 specific vmaflag to represent a shadow stack VM=
A.
Since this is arch agnostic code. Can we instead have
`is_arch_shadow_stack_vma` which consumes vma flags and returns true.
This allows different architectures to choose whatever encoding of the
vma flag to represent a shadow stack.


>                         if (!(gup_flags & FOLL_FORCE))
>                                 return -EFAULT;
>                         /* hugetlb does not support FOLL_FORCE|FOLL_WRITE=
. */
> --
> 2.17.1
>
