Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59AF23C090
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHDULO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHDULL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:11:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D674C06179E
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:11:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so3147516pjx.5
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2mYBNPQlfulBGUiUF3OgK7lyVU+rDyXfhP91vVVFlg=;
        b=GJ9lUIQlhroAI9Qx0p4xmfgldOZs2AAE7pAVHI5pia4oB28x7V5RY15F/VqXapy6iy
         +vXVYP7NjtUN1l+aR0ZQnHCWlDFuL18tWhTXS/PwSPqoVO3hBNUKm43IZoIJZ/06Ir+M
         zH6FXNGCHY+XcwW1EyKxk9ytILNMg0DKJ+cTJguzuIjlYGvDn4t/3GhtAD/UWaeBYO1v
         K2o4QW831rzwLDp53xjnW/cQLdUOy+++a/SctmAFLEQVtM2BJawtJ1+KySFzPmYfPrLg
         dFKXIFv4DQyGBXPiAZ2QRblRglMrrSdG39E+6Hcr+1HX6L6jjj+vcUfCC2N62nXow1AS
         wMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2mYBNPQlfulBGUiUF3OgK7lyVU+rDyXfhP91vVVFlg=;
        b=cLxcCSNXB7z+NPLSxd+NUm9O65ZzD0+PgGmmsSAY8PmD+R5mmr1H3+GUZUJcFInJqh
         yZDybcIOnnXujlzr7tZErD5o3yvgfcts70b3NZTJ5+X3exOdWargX3RCs7c2UfUbDypv
         /WuDqAGHr09yuiAfKwEG2nxKk4i/pBBedkKL86OkfzjALgRdIvlCp0rNK8CwFG/xiPQR
         1D47BcEPVUrL4BF9aCTXneEqWxuMKZsAvwoDrECUC5cFvzmlsJs+3iB3NfEcJs4wflmH
         6o0GXbXoLkuNbmncANErEid3IdpzA8x0u/1h62egIjRZzrX3XyDKRFtsfp2yz2K4Kd0V
         If0w==
X-Gm-Message-State: AOAM533UCpcub6zqY9vlAaVxMAsubOdbpSWmJM6/Y0QEU2Q9kHtBRD+s
        IFyH8gKEsDeZkohNi8+eeCic43sRldzAgAwfecXFZg==
X-Google-Smtp-Source: ABdhPJxl+Kd8Ihx2ttUsvcGN3ycEyHEQYEvKffflaWl/EyeALM0vmg4FTGKzFLgIPV5XkISHcS2NVNq9x6QlLNDzIrY=
X-Received: by 2002:a17:90a:c593:: with SMTP id l19mr6141441pjt.20.1596571870728;
 Tue, 04 Aug 2020 13:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-10-brendanhiggins@google.com> <202006261434.119AE33DBB@keescook>
In-Reply-To: <202006261434.119AE33DBB@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Aug 2020 13:10:59 -0700
Message-ID: <CAFd5g45HeXUBVNW31ZYgpqhYOOu=1jwK_LKZQUOO_6mGaqtSUA@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] kunit: test: add test plan to KUnit TAP format
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 2:35 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:14PM -0700, Brendan Higgins wrote:
> > TAP 14 allows an optional test plan to be emitted before the start of
> > the start of testing[1]; this is valuable because it makes it possible
> > for a test harness to detect whether the number of tests run matches the
> > number of tests expected to be run, ensuring that no tests silently
> > failed.
> >
> > Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Look good, except...
>
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> > index 62ebc0288355c4b122ccc18ae2505f971efa57bc..bc0dc8fe35b760b1feb74ec419818dbfae1adb5c 100644
> > GIT binary patch
> > delta 28
> > jcmbQmGoME|#4$jjEVZaOGe1wk(1goSPtRy09}gP<dC~`u
> >
> > delta 23
> > ecmbQwGmD2W#4$jjEVZaOGe1wk&}5@94;uhhkp{*9
> >
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
> > index 0b249870c8be417a5865bd40a24c8597bb7f5ab1..4d97f6708c4a5ad5bb2ac879e12afca6e816d83d 100644
> > GIT binary patch
> > delta 15
> > WcmX>hepY;fFN>j`p3z318g2k9Uj*m?
> >
> > delta 10
> > RcmX>renNbL@5Z2NZU7lr1S$Xk
> >
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
> > index 9e89d32d5667a59d137f8adacf3a88fdb7f88baf..7a416497e3bec044eefc1535f7d84ee85703ba97 100644
> > GIT binary patch
> > delta 28
> > jcmZ3&yOLKp#4$jjEVZaOGe1wk(1goSPtRy0-!wJ=eKrU$
> >
> > delta 23
> > ecmZ3<yM&i7#4$jjEVZaOGe1wk&}5_VG&TTPhX-Z=
>
> What is happening here?? Those logs appear as text to me. Why did git
> freak out?

That's because this is all test data; it's all plaintext, but out of
necessity some of the test data is kind of munged up and causes
checkpatch to complain, so Shuah asked us to mark it as binary since
it isn't actually code and so checkpatch will stop flagging it.
