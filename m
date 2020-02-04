Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB5915213A
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 20:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgBDTfo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 14:35:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgBDTfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 14:35:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so10143515pgk.12
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBYf/F2Io0atf7tGD69pezEGXYzc+ynKJmxs01qZzAA=;
        b=QOo3HD1vuYYlz+4sD+zhB2tClXMUNBEVMlO7WB2JZ9IV9rmn7SF/rbwkwtEq2KhqH6
         JflMkH64e2XW0chioVXoRklQSjZ1ThVCqfFd4QNQZvy3cCKTKktltJOOJYcsi+dOXsiA
         xyKnNbIPPvpQIbEox4KqyaNXHcxW2y550fV9m69L6uSplE435tmpgX9LGNn5cxycQCX2
         WnL4rVBZyAfqQEJjgaX6r9LnrYU1cW8yz106G9HwDqFdmwyb5weFPXRl0cmTQUDEgiOT
         IuHegvLBA08oEM5t1e51IBhTgVFYRvE/0qHfcPD02u5/ihsaye3NxsNp4XwMhOnq9rty
         pXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBYf/F2Io0atf7tGD69pezEGXYzc+ynKJmxs01qZzAA=;
        b=mTuDHPX2dUlZL0QpBTSvOowhqMZxt2NWjPi/eF7F0WDBT/7QIfflvLhPVMf8SgL/eN
         eAU+CTKJs7TdUXD2fKfcEqs+hOiALyYGZTnG+13fCc0aUNEr+7k686bBTNvaZ3O1b65h
         8cc00nwQcT3TyplSuXkoIF9KkSQeY1wYfi9Uz2SiIo56/8kR/Xwwo2ppIMFKX5cPYu3M
         k3ZNsJVSmUZXce4VOEoz4AMMmN80KbT1GXfAw2KYdI0v3vmR3+M2el4ji2dCH0MAtBRs
         UP7NFLz4zUm/88YDjk/JT0+0NfEhZRt3GyFzPDLD1zIu5fmhHgR0gtr5XP3yfX1nd883
         ciUg==
X-Gm-Message-State: APjAAAXXThDHscse/s8WkT1eEy/Jr+gGdviW2Yoe+clGfkLQ+KuWQT7k
        RtdsdB5w48shMcPKnGga0qfEpaJZO0oc2IQoA//H2w==
X-Google-Smtp-Source: APXvYqw4q+KWhmmtYLJvBYiGMg4pK4goKHR2pzDq2KQ/ueAn46fzf63AjOWVV2VKJzLV/wvMXo/IxMlPJ94Rwb3Ob+8=
X-Received: by 2002:a63:3754:: with SMTP id g20mr17958855pgn.384.1580844941362;
 Tue, 04 Feb 2020 11:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com> <20200204071915.AF32B21582@mail.kernel.org>
In-Reply-To: <20200204071915.AF32B21582@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 11:35:30 -0800
Message-ID: <CAFd5g44ZG+E==gT24w49oKc6nHv4nBQFeipikKxXJH3oHdO99Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 3, 2020 at 11:19 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-30 15:08:05)
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
>
> Is there any diff from v1 to v2? I don't know what changed, but I see
> that my Reviewed-by tag has been put on everything, so I guess
> everything I said was addressed or discussed in the previous round.

Oh yes, sorry about that. I have gotten a bit lazy in regard to
changing logs. I noticed that a lot of people don't seem to care. I'll
make a note that you do.

Changes since last revision:
- On patch 6/7, I flipped the include order and removed braces from the if
  statements.
- On patch 7/7, I removed the periods from the short descriptions.
