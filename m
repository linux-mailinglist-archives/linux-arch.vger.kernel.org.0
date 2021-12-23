Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28947E6D8
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349488AbhLWRUs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Dec 2021 12:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbhLWRUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Dec 2021 12:20:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E31C061756
        for <linux-arch@vger.kernel.org>; Thu, 23 Dec 2021 09:20:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y22so24079803edq.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Dec 2021 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6ewMJ2Z+IzcgF6xIUMHr0fBNib7MLyFPwMExIntXDQ=;
        b=Nh/JZnZIQKCHcPVE2zpqDRAQAn0zb++R5dsUx6CD9Px4tIKzLNH7ltOy99r46sform
         XbYcxDbgfY9qMeDQTvAylVkdl84hTQIpccqjy/whmUbb0NTpxCu88QbVwqlRJXpX5Jhg
         1p8NIZQrFDAHm6FTOXtluShv4LkDp+sGEoVI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6ewMJ2Z+IzcgF6xIUMHr0fBNib7MLyFPwMExIntXDQ=;
        b=jE32J9i+2OsMofAOmcoBMkOAEdkVk6B8GWbphOp0cWR5xCcf3MG0z5iZnIhVMiMc1K
         yjm76RNYtGTqUsRZkPaDjQddA8PzLNYhTPrkIgGzbFwIyXj6cvY6JXKH0/YwYdUOKEU6
         huhnZsIJjkrHm68yDdtXYG9hcoRgc3c4knWOTNTaVi3RMXE5c6+Ls86JwGgx37FvAVv0
         4U3nBIJ3jcXcZbeWRqBkEEpX07+R22b87kNRIwLWFPSBjApvqJS7OY5JRQ+b1ONjI1iw
         Oa/eedJ6sxVqmavCMZXTAtYvN8+gpif7+98wKiACVKFHGj6jb7WPqWX8iz+QX19Px5wW
         bI9w==
X-Gm-Message-State: AOAM531hj3H+XT+AueRwpq5o7NDb/DXwWuuDA1CqYqWnQ7RkKihroMC1
        /4NyADGEUy3JB+LvyFRhtylU08JaODdqmA/WDtY=
X-Google-Smtp-Source: ABdhPJyqbdnmGeB8/Z34Ww+bvooY0IiZ72BONsB3/52CuAsm0fRnN07yssxDlHJKea9WsoQ5vsBpWA==
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr2801175edd.63.1640280044405;
        Thu, 23 Dec 2021 09:20:44 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id q21sm2163677edt.45.2021.12.23.09.20.42
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 09:20:43 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t18so12728468wrg.11
        for <linux-arch@vger.kernel.org>; Thu, 23 Dec 2021 09:20:42 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr2336024wrx.193.1640280042472;
 Thu, 23 Dec 2021 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com> <YcNsG0Lp94V13whH@archlinux-ax161>
 <87zgoswkym.fsf@email.froward.int.ebiederm.org> <YcNyjxac3wlKPywk@archlinux-ax161>
 <87pmpow7ga.fsf@email.froward.int.ebiederm.org> <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
 <87o858uh80.fsf@email.froward.int.ebiederm.org> <87a6grvqy8.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87a6grvqy8.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Dec 2021 09:20:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmsosJkXoN+arC6eUdayq42pTZzr1j0rG3=RsPBgqujA@mail.gmail.com>
Message-ID: <CAHk-=whmsosJkXoN+arC6eUdayq42pTZzr1j0rG3=RsPBgqujA@mail.gmail.com>
Subject: Re: [PATCH] kthread: Generalize pf_io_worker so it can point to
 struct kthread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mike Christie <michael.christie@oracle.com>,
        virtualization@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 22, 2021 at 9:19 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead of continuing to use the set_child_tid field of task_struct
> generalize the pf_io_worker field of task_struct and use it to hold
> the kthread pointer.

Well that patch certainly looks like a nice cleanup to me. Thanks.

                Linus
