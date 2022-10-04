Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411EF5F3B14
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 03:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJDB4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 21:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDB4U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 21:56:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C932D778;
        Mon,  3 Oct 2022 18:56:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 70so11570614pjo.4;
        Mon, 03 Oct 2022 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=IUIxHgJYWcHGaS/qJFBxYXjYwMIOrkLEaJu/xQNKfEQ=;
        b=aKmGtBJE8VNe0EZE7dHTOoTQnKr33h5A4fz5n/RaLhpnf1RHcnEVEG45rGQZjNjY49
         LrtfZ7iAK6i0asA6CsmDCLH4WSl5WY3+jR0ijHAzLVnO89szKZvyex5xcDNRQQ/REXhX
         dJx+0CXbZv1hCkrd0Wu6pyaOiOwFnf3LaEtyy0ulvhBkeP/mOMy0Rlu2vXUAJbdXiHAd
         9+2BQaZ7bEicPlGSagnR8iN7XmX+ADdNKWgr3ti5IsyWD/v2QonYTwPvGAM0p6U8OjJ+
         r3pJfhJFUcCqo7xt8DNWI1cWyaEGnWYIeXH77kDnjGeXZSE3+6XTDyPE7BnipIZTesB0
         TSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IUIxHgJYWcHGaS/qJFBxYXjYwMIOrkLEaJu/xQNKfEQ=;
        b=aWgV1PsYbYCZuh7PmRIgJeWvaN/vAtJjENocVd6GIVLkJL060NBgY0/434wiYRqJTx
         JtYchK7KnqYkQxtJdqODF29wZfm4sViA3wnwBW9y9m+iWZCDSNe25xIwxM2MaGzUtNa+
         ednVwBx9Reuvtvwa2lOMnAFvjap1pxvqUKju5eXqlhYlckm6uITGmI0/hOFYIyfIDsk9
         FzlKyDhiUA1CMdwng9s/dfyfLQNSlm3MrUC4lN5+XPNG3tm3/ISS8u3Lw8XzM605HR9h
         CP9DFa2wHzJxQKWQOC2eP1d76oC2k0MvcDxY+b2tt2wsBi5mflctR/keJjRGOHe0B+5z
         Ifmg==
X-Gm-Message-State: ACrzQf2Lt4lyfOJvt0tUlm/Ylae+v/OMdWkLVpVxdQ63MaGvYo0Bx/aW
        9+jVMO6pFvl9TRz4ZRCbvSw=
X-Google-Smtp-Source: AMsMyM6BsRvc9pwadnammyxGl8ehM6JvyxAhCPZ142D2t0y8sbOHs4tx8RnG8eFOcCU4x3RllKHJxw==
X-Received: by 2002:a17:902:a611:b0:178:6b71:2ee5 with SMTP id u17-20020a170902a61100b001786b712ee5mr24393638plq.53.1664848579309;
        Mon, 03 Oct 2022 18:56:19 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090ad38f00b00209a12b3879sm6955729pju.37.2022.10.03.18.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 18:56:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220929222936.14584-18-rick.p.edgecombe@intel.com>
Date:   Mon, 3 Oct 2022 18:56:15 -0700
Cc:     X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Mike Rapoport <rppt@kernel.org>, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <96BFE665-4A76-4CE0-A22B-A999C4A16FFD@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-18-rick.p.edgecombe@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
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

Hopefully I will not waste your time again=E2=80=A6 If it has been =
discussed in the
last 26 iterations, just tell me and ignore.

On Sep 29, 2022, at 3:29 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> =
wrote:

> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -606,8 +606,7 @@ static void migrate_vma_insert_page(struct =
migrate_vma *migrate,
> 			goto abort;
> 		}
> 		entry =3D mk_pte(page, vma->vm_page_prot);
> -		if (vma->vm_flags & VM_WRITE)
> -			entry =3D pte_mkwrite(pte_mkdirty(entry));
> +		entry =3D maybe_mkwrite(pte_mkdirty(entry), vma);
> 	}

This is not exactly the same logic. You might dirty read-only pages =
since
you call pte_mkdirty() unconditionally. It has been known not to be very
robust (e.g., dirty-COW and friends). Perhaps it is not dangerous =
following
some recent enhancements, but why do you want to take the risk?

Instead, although it might seem redundant, the compiler will hopefully =
would
make it efficient:

		if (vma->vm_flags & VM_WRITE) {
			entry =3D pte_mkdirty(entry);
			entry =3D maybe_mkwrite(entry, vma);
		}

