Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5E10956F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 23:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfKYWKl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 17:10:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33729 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYWKl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:10:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so20139586wrr.0
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GItM9XLVqxNn0sdCUQLWJSBGa3kbJqyrc/moSFwmETQ=;
        b=t67XsscUtvcYGFCu8/pIb4nslkXMYNqiyJiOG6SoOj4ZqNd89J3VGLiwTqIUI6b9J+
         7DbWj7wFe+bCCtuCpWSvdHNJbtWiXZT3f8I4rQw7DYAJgTSB4VHF2sh2RbifavpAMLsO
         dL+RcSI7YmWFOZWpd8Em6jFk1VHTJbqQK1jeRIxyVW3wRGcnhvKTHXSGgkZbuhYtulFu
         jDecJAvU4i18f4G0IjLJULRXdmHXrccFv2TZFs16gxm6SCLI33T4hSFI/5OtwQzGU1UB
         XLpjn571eDW1ABVd0EyWibRC+MTK10vsVm0oTRuQ/BA9v1TSpIz27cbs5rdLu/M3jcdi
         7UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GItM9XLVqxNn0sdCUQLWJSBGa3kbJqyrc/moSFwmETQ=;
        b=QOJyam0Y3nHhRXUAC/bbZucV2xmW0Xgs2EPr1XTn2lJH9zyQt4ppCC+zOV4NKKAaIN
         1T3/BVCHGDzwvUmaqdOl9lAMM1RRRqf1nmPSpjh5VB30MPSssSgXDJ2hiKwakERAd6rs
         DwfFRHM64aD2DIva5xwShsdWtjfvR6rM0ZMVyHtzqvLXZNcgr2s3XZDv80PnPccPH7jV
         fA65EvzaJ4RaqPKxuqa2UOqkiIz9tnNmvyPr7WtFe5o8kUI16To65rqTVG60S8bT1Ibx
         YFPxt2oBA5Dtm8jHtqZ6ojyHfGSWdgW30NUd0ndnJ9xuKjr1R78e2yaB85mXtxYBqL22
         08WA==
X-Gm-Message-State: APjAAAUcuejuQchNakRlq2HTUY1LdANJpcP+Kt31KIOjUCUVpRcnIyzI
        1wLiK5CL8zz0QRpd1jF2SyOwnEIYOi5O1NrfT8o=
X-Google-Smtp-Source: APXvYqwBxzAgMD5XGrXyFXjrbhvtES5ZQl5cOm5abQnJ/u/OZu7x70kQ6wDw5nzpVIVbQS0elzuU7ZjqYZOS8PWR1NY=
X-Received: by 2002:adf:c449:: with SMTP id a9mr32838029wrg.240.1574719839492;
 Mon, 25 Nov 2019 14:10:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <8b0c833bde42e761cadfd3542263ad7a8be5eb5b.1573179553.git.thehajime@gmail.com>
In-Reply-To: <8b0c833bde42e761cadfd3542263ad7a8be5eb5b.1573179553.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 Nov 2019 23:10:28 +0100
Message-ID: <CAFLxGvw_tkmAq0nGrgEs8jQFGLADDuAyUOsYhdDzAH5yhHFHEA@mail.gmail.com>
Subject: Re: [RFC v2 05/37] lkl: memory handling
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Levente Kurusa <levex@linux.com>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Yuan Liu <liuyuan@google.com>,
        linux-kernel-library@freelists.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> LKL is a non MMU architecture and hence there is not much work left to
> do other than initializing the boot allocator and providing the page
> and page table definitions.
>
> The backstore memory is allocated via a host operation and the memory
> size to be used is specified when the kernel is started, in the
> lkl_start_kernel call.
>
> Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Levente Kurusa <levex@linux.com>
> Signed-off-by: Yuan Liu <liuyuan@google.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  arch/um/lkl/include/asm/page.h          | 14 ++++++
>  arch/um/lkl/include/asm/pgtable.h       | 62 +++++++++++++++++++++++
>  arch/um/lkl/include/uapi/asm/host_ops.h |  5 ++
>  arch/um/lkl/mm/bootmem.c                | 66 +++++++++++++++++++++++++

This is also something which needs unification with UML.
UML in NOMMU mode would be LKL then...

--
Thanks,
//richard
