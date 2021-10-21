Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF56436824
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJUQmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUQmC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:42:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE6C061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:39:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c4so801918pgv.11
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyAOi2FE05WhmGaZ/0cqvrOcBf/dkwT9gOUuxN9w9GA=;
        b=jYgyXiqPumcD49shPwoXVmC/gIY7r+DYzq+Pma+iNOKYLaHngkv7+SYxYp2n3nSH2P
         DIDhhwcfkb9T5UKEo1Qs6iZdCkpuKQjuSoBxFhzYj8gwxYjasWHJb/hDnisLJuk5PLP5
         THE+AGwKaANrMi2Nc69l6W6iiv3hREppHuhDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyAOi2FE05WhmGaZ/0cqvrOcBf/dkwT9gOUuxN9w9GA=;
        b=0ylrNO/1/0/MJJ8T5xmMHnHsHKwZeurXx/4533J8kPIOCYu3zEefVInwETQe8YN8Mv
         wdxG/JlLNV4+avhIy9i6dfZiPxjReU5pYTk5a2ZO/NnXzS/NYOBSjEIh3vydRIUV/2GL
         a3+vY/uqZ8UGYUd8yzcoMKqO/0zvE/HxNfuoWUB2JMuJ4AejRhSjcQDd5v6tMs39XG3G
         dDQTC5VgwyzyDD8PQYDiF78syLRhCgoNOibTGQcbQH/yedPCyacvkYT1YYsZ5Y9Kj/Ja
         q2KnhNhonexMzFXCcBEKp1q5duu7uREC5QGqqsO4uvxpewOj2CrNHVryvefq3EeWzQap
         gqXg==
X-Gm-Message-State: AOAM530XiTm6AMPtxHk8CXfZh7OjXxeepP6Qaa4lwfUNRJPixM722ZMw
        8wedFpm9D3SAbif3SFf9yI85GZC+BKunLA==
X-Google-Smtp-Source: ABdhPJyMuZZg1OBPksPOcZo6oRdHM9W27SIB5qzN2juk54rtqfSJWsgGqzMJmSRW+tA/Eu8p+UZtPg==
X-Received: by 2002:a63:f155:: with SMTP id o21mr5240024pgk.218.1634834385909;
        Thu, 21 Oct 2021 09:39:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x129sm6861175pfc.140.2021.10.21.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:39:45 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:39:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
Message-ID: <202110210938.FCB7CEB96F@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-13-ebiederm@xmission.com>
 <202110210923.F5BE43C@keescook>
 <87ilxqbamw.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilxqbamw.fsf@disp2133>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 11:33:43AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Wed, Oct 20, 2021 at 12:43:59PM -0500, Eric W. Biederman wrote:
> >> This is interesting both because it makes force_sigsegv simpler and
> >> because there are a couple of buggy places in the kernel that call
> >> do_exit(SIGILL) or do_exit(SIGSYS) because there is no straight
> >> forward way today for those places to simply force the exit of a
> >> process with the chosen signal.  Creating force_fatal_sig allows
> >> those places to be implemented with normal signal exits.
> >
> > I assume this is talking about seccomp()? :) Should a patch be included
> > in this series to change those?
> 
> Actually it is not talking about seccomp.  As far as I can tell seccomp
> is deliberately only killing a single thread when it calls do_exit.

Okay, I wasn't entirely sure, but yes, seccomp wants to keep the "kill
only 1 thread" option, which is weird, but useful for the threaded
seccomp monitor case.

> I am thinking about places where we really want the entire process to
> die and not just a single thread.  Please see the following changes
> where I actually use force_fatal_sig.

Yeah, I saw that now. Thanks!

-- 
Kees Cook
