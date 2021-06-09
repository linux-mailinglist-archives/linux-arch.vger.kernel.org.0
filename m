Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34043A1B50
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFIQzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 12:55:39 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44961 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFIQzh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 12:55:37 -0400
Received: by mail-pl1-f176.google.com with SMTP id b12so6874217plg.11
        for <linux-arch@vger.kernel.org>; Wed, 09 Jun 2021 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LD9HSxwVBYD4Eigmm4/eFaSooe5X81yBa6b9diyTxLk=;
        b=N47Q7iKRccjNkYwWKqUHqFn73mIgkb6yUnEgVpfiCnpd7KGAo+RwkJGh7fCyhsJ5rJ
         PHoctqrgLpYFlXiogoGImI85Yu3OsLM3sfJYRnwP4OzsOAGtIgoKDG+IYVT+VOE0fTE/
         27PJSIvlhBf+evKmhRLXx/yOa0KOermG9co7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LD9HSxwVBYD4Eigmm4/eFaSooe5X81yBa6b9diyTxLk=;
        b=N7U5O6cFh2yWX6N0vZSdJ9KR+Onb6aUxyLYQ7aGLD5ytxtV5cVMMOKIjFH3bMhdhDo
         pahuNmH/G2xXr2LhNLPJnBsyivOVSV2pBKEambCRoEXdQE9zsQe8Cd/NZKAjVeBb4oKp
         jwxPl4Hz2Bibw6ATeXbeR9yI1uPze9XhWt33HroqeTQatZI6xNuR87G9y4Z5uBHE1IF4
         uCvO3TzaFO9DaKvfrEb0i9l0byD+0sAwXC2L6MUepAjmruEhalse9dDFLMNaw67UQQAF
         X/Wv+UhkcF8L0eeuR5T6Wgk3W9RKpkVrOaEDIgu24wePwODSkxPphf/D2zZ+KloS64oH
         e4OA==
X-Gm-Message-State: AOAM530bkuAVslRYssCwJbJ7Y14LFyhHMeYv+bEChhsLHISObNcdeM3o
        2B4OUxgzBi4/i3maCuIPalGJeg==
X-Google-Smtp-Source: ABdhPJzNXeQzlTinS1wmW8MEliQZalVLosypCXm6YUl9Lebh2/tT7cpsPFLagkE3mdC+ClBbYzFVAQ==
X-Received: by 2002:a17:902:988f:b029:114:12d2:d548 with SMTP id s15-20020a170902988fb029011412d2d548mr479973plp.73.1623257550841;
        Wed, 09 Jun 2021 09:52:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k30sm305187pgf.59.2021.06.09.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:52:30 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:52:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v8 0/8] Fork brute force attack mitigation
Message-ID: <202106090951.8C1B5BAD@keescook>
References: <20210605150405.6936-1-john.wood@gmx.com>
 <202106081616.EC17DC1D0D@keescook>
 <cbfd306b-6e37-a697-ebdb-4a5029d36583@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbfd306b-6e37-a697-ebdb-4a5029d36583@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 04:38:15PM -0700, Andi Kleen wrote:
> 
> On 6/8/2021 4:19 PM, Kees Cook wrote:
> > On Sat, Jun 05, 2021 at 05:03:57PM +0200, John Wood wrote:
> > > [...]
> > > the kselftest to avoid the detection ;) ). So, in this version, to track
> > > all the statistical data (info related with application crashes), the
> > > extended attributes feature for the executable files are used. The xattr is
> > > also used to mark the executables as "not allowed" when an attack is
> > > detected. Then, the execve system call rely on this flag to avoid following
> > > executions of this file.
> > I have some concerns about this being actually usable and not creating
> > DoS situations. For example, let's say an attacker had found a hard-to-hit
> > bug in "sudo", and starts brute forcing it. When the brute LSM notices,
> > it'll make "sudo" unusable for the entire system, yes?
> > 
> > And a reboot won't fix it, either, IIUC.
> > 
> The whole point of the mitigation is to trade potential attacks against DOS.
> 
> If you're worried about DOS the whole thing is not for you.

Right, but there's no need to make a system unusable for everyone else.
There's nothing here that relaxes the defense (i.e. stop spawning apache
for 10 minutes). Writing it to disk with nothing that undoes it seems a
bit too much. :)

-- 
Kees Cook
