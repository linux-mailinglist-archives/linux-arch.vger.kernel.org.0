Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD50381D4A
	for <lists+linux-arch@lfdr.de>; Sun, 16 May 2021 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhEPHl2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 May 2021 03:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhEPHl2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 May 2021 03:41:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5C1C061573;
        Sun, 16 May 2021 00:40:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h16so3174371edr.6;
        Sun, 16 May 2021 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=atWgUCMhsGNXsz/gNWslNxnGXhNwsHL+hDk1DcVED5I=;
        b=o+vUNgadmD0yG7ldn770Bb8R/zCV9GVEAt2UQQgCpBYujRUcZ0bCjdGg6Kl4jkaas8
         S0V6VzF0REg8zl47sc/j+VqUQdyLhbWw4v6ZAEMvjvLY94MrULU/vfcAA290OAibDlN1
         hqs8NO0ot0ihSBmgS9aqW6g8D5XOWV64EYrFyCzAmEGV4XLWNJpNIVgCb1STq9ccQtaa
         LkyV02smdfsnhJ8F0sprAbzmAnI9zfua3zHyAKDYYytbQ+BMY56S1FazZL3GXa4Lm/E4
         +T/AEmucL4l2a8/XpdVYi6Mtz9ardrLgy7jV6kLACg1FBMeU+fcdeY5zuBk8I2i9Imhx
         j7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=atWgUCMhsGNXsz/gNWslNxnGXhNwsHL+hDk1DcVED5I=;
        b=MjpIShKYFqWAi3MNGC/N53t0uvNttiMDoOhdJkXxkr65OlKSMwcR0qsdR5EUeYLBG3
         ZRFHDtmCy8MLBSisdBthzODgs5PfKB4V5RRh3cAIWfMBvCBXPsnpeaVNuLRLihUBZN7B
         LfnFJdPJ/q/31fI0DC1I0buz1Z8DR5sTujj1O2l3og/zUE7KMjICLw32U3NCcoYy3PdJ
         ryHmzHPc95efC44t65nihXFTm/YhHjPAZ88nrVwB5Nmzntq4n5yhGfzFkMsu/9hgoP/t
         TijQDiF2eTbEIkFxXtpTNMEHxPoG6Y8BKE4c9+3nVmUFPX84yJffhjI+ZX59WlgsGvO7
         e4ig==
X-Gm-Message-State: AOAM533q3D83uy+HcQm0/gCZnv7Ia4M+mvCiRI+N90EU7PfAhLb5DssP
        fh63QLSTj8izNQXLClfiMBI=
X-Google-Smtp-Source: ABdhPJznuZaMygYqm29ZlMZ/DJdjVZpnXsklUT6JzAXgsF7zw2Quk4pm5AaDKPD6F+NvV4wUK01hzQ==
X-Received: by 2002:a50:fd13:: with SMTP id i19mr22824583eds.386.1621150811730;
        Sun, 16 May 2021 00:40:11 -0700 (PDT)
Received: from gmail.com (563BBFD3.dsl.pool.telekom.hu. [86.59.191.211])
        by smtp.gmail.com with ESMTPSA id qo19sm1799357ejb.7.2021.05.16.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:40:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 16 May 2021 09:40:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
Message-ID: <YKDMWXj2YDkDy1DG@gmail.com>
References: <m15z031z0a.fsf@fess.ebiederm.org>
 <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
 <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org>
 <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org>
 <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <m1a6oxewym.fsf_-_@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1a6oxewym.fsf_-_@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Looking deeper it was discovered that si_trapno is used for only
> a few select signals on alpha and sparc, and that none of the
> other _sigfault fields past si_addr are used at all.  Which means
> technically no regression on alpha and sparc.

If there's no functional regression on any platform, could much of this 
wait until v5.14, or do we want some of these cleanups right now?

The fixes seem to be for long-existing bugs, not fresh regressions, AFAICS. 
The asserts & cleanups are useful, but not regression fixes.

I.e. this is a bit scary:

>  32 files changed, 377 insertions(+), 163 deletions(-)

at -rc2 time.

Thanks,

	Ingo
