Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF87B279A56
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 17:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZPVs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 11:21:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZPVs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 11:21:48 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MF3U0-1kFbO613Pc-00FPq7; Sat, 26 Sep 2020 17:21:46 +0200
Received: by mail-qt1-f176.google.com with SMTP id g3so4789034qtq.10;
        Sat, 26 Sep 2020 08:21:45 -0700 (PDT)
X-Gm-Message-State: AOAM533d79cxbgXIsayT6PSAuxCKuFW83NIrpDAd16+e5uCPTIODoPZs
        g9JefNnmnCfL0AKg1HYBUsvqyBICvlEfqPLWaZs=
X-Google-Smtp-Source: ABdhPJzhhuU4Qjx8HuF0NAIPjTlcDnIE/zYRakYWeCOK+DeEFjsGcCAX1OrxiRvWxcnqtBK6Fiytjj76wV0F+2OJne8=
X-Received: by 2002:aed:2414:: with SMTP id r20mr4939375qtc.304.1601133705038;
 Sat, 26 Sep 2020 08:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de> <20200918132439.1475479-4-arnd@arndb.de>
 <20200919053807.GK30063@infradead.org>
In-Reply-To: <20200919053807.GK30063@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Sep 2020 17:21:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15GEGL8AnxTYZxD_EeGb7__v=iy6rTfCTNq2jmsQe9fQ@mail.gmail.com>
Message-ID: <CAK8P3a15GEGL8AnxTYZxD_EeGb7__v=iy6rTfCTNq2jmsQe9fQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: remove compat_sys_move_pages
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KVXfAnkhrAtApTZq7lgk8gNfG/j8L7eQ9Pmlq/r+fW+yLH7BfZl
 CKUjxn+uimjTYgcEgLk4YYOFtvO+PomwzTXXDalcCZuXZ+0nTXhHewvG2UL5EirUJq7sAlI
 R2gzN+XdtEObx/dr+klo8i1omBylTgmyCvl8Nlnofqe2xO5C4a6Yh++Ig1a5rgd8PQ5nhHx
 su0JvKjLDq6ddczdLxk9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qo8WD57aOQA=:spANsabPq/6dUBbWKRIwaQ
 lz2wd4dNV2/MMRpMsHOTRrsSl2FgDKdzKqzFMWVfZbVMenuRuAfPH+QD+e4uWQfvQlThJotE6
 E4mx1fflOIQYEfg54TABF9XOnw347EnzH/uwXwihNAki5zFR1tHqFP2+jXfTWtQnm/RKLPe/U
 X7YysNR4f3EUoSy5L6k32LFXeLWJvmlP0aBmkDV7/+B05J4wgOsPDHwU5jmQkx2fiUTnxPgie
 qYYO6DDNbqXDrOOIJAExn6BG3XzV5OtTf56Dma0GQfPd77vS3nQ4Gx8lqgpehoCI7f1GachS4
 DkYQsnldBYoRUnQ+/x708GYlA8tA7ZDzwZRByH3nQW3a4CiAKOrXzL40I0I80uzDT+Nj5hEIR
 7Y8Q+Vs8NtSta0K4VCOHsm4mchG0SIkmIvA19mmrtKwnPwIABQMGJPqw41NfMh3sIN4KqV/hA
 g6u3R6w/VcZvei0BXo98WxZjSKJ7NR8D2oBLiZ2XuWyfl8RxnMAmBvSX7p+fQWKwSeMrDzeiD
 X3UnqZcKD9YeqKRXFya1+4o3TbMlYj6kS22DP6Me1FskhIYv2Yoxj9I/Dji7q2SVgzaUGDDZZ
 zymBo2hDGaCQLbLZBwlyUyQwi2tH1Vgf2tt5DATa6vG6kYOh6NDTM2V987BzzvP28+jQLPg0b
 0WY3N/P/hZmsLKqrY8BFaVqc6xOvI17MkYT65yajM/EOAsEhNg8mTLqtTjmkQFt2u9PBrpBAa
 EwABFcEnmF8quFFtihLlrp2PI3Opp0xQW9kfuY4Ps8Y+EPY5cjAYhkPEVW4y/gyrutiS5DmFB
 9TIJ+jcdcu4+8zb7k0/cTeyiu956ngR7RvNbKw4NhVqCl/F9O/i0tvEv8e/6BimT2kfOuB6KF
 pvGZec/Vd8jwwVO3hcdVNRdh7+ofHisg31o2vpgmACd6ybXzpM8krDJUygqmTfYKjsTsvhHdy
 qhSJ2HGV9OombXt043a3H4Dtr5Ys0zUsMhZ5DomvDtHsZoCYnadEu
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 7:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> I'd just keep the native version inline and have the compat one in
> a helper, but that is just a minor detail.

Folded in this change:

diff --git a/mm/migrate.c b/mm/migrate.c
index e9dfbde5f12c..d3fa3f4bf653 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1835,18 +1835,14 @@ static void do_pages_stat_array(struct
mm_struct *mm, unsigned long nr_pages,
        mmap_read_unlock(mm);
 }

-static int put_pages_array(const void __user *chunk_pages[],
-                          const void __user * __user *pages,
-                          unsigned long chunk_nr)
+static int put_compat_pages_array(const void __user *chunk_pages[],
+                                 const void __user * __user *pages,
+                                 unsigned long chunk_nr)
 {
        compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
        compat_uptr_t p;
        int i;

-       if (!in_compat_syscall())
-               return copy_from_user(chunk_pages, pages,
-                                     chunk_nr * sizeof(*chunk_pages));
-
        for (i = 0; i < chunk_nr; i++) {
                if (get_user(p, pages32 + i))
                        return -EFAULT;
@@ -1875,8 +1871,15 @@ static int do_pages_stat(struct mm_struct *mm,
unsigned long nr_pages,
                if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
                        chunk_nr = DO_PAGES_STAT_CHUNK_NR;

-               if (put_pages_array(chunk_pages, pages, chunk_nr))
-                       break;
+               if (in_compat_syscall()) {
+                       if (put_compat_pages_array(chunk_pages, pages,
+                                                  chunk_nr))
+                               break;
+               } else {
+                       if (copy_from_user(chunk_pages, pages,
+                                     chunk_nr * sizeof(*chunk_pages)))
+                               break;
+               }

                do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);

It does make the separation cleaner but it's also more code, which is
why I had it in the combined function before.

      Arnd
