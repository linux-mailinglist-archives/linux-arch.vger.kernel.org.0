Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880C43672F
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhJUQE4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhJUQE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:04:56 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06DC0613B9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:02:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c4so707673pgv.11
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/CORXWW/B4Qwj9AW68aZ4KNhoZHxannWXjlHOATBFC4=;
        b=eGCVh7iu96H0jRAA2kNpooj8KoN8V+qF5k/tMPYh9T8dj2P3h4M7h2OwVOz9gRAYd3
         GQLgCcRbEv3HZ17b/U3sjewF7mffVFwlm6KExyl4WkMr7aoai3qMajnrEcAbSH+lS6O0
         tyzGk2y/9jXCk6Sc9R45O3mFm+kM0OBVNLbIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/CORXWW/B4Qwj9AW68aZ4KNhoZHxannWXjlHOATBFC4=;
        b=fvXKEotElSaSQOUHW9Lat45VPOe3sPs0tzHfSrMNbFK7KdIVDMFsbBam2SvZbjW2yf
         tLgmDKX5W3FAMnq00YCP1RpsSeyeGA1/AyiwLg6qJNnAHNBgpP27QCgElvedduQ+0shM
         M7U4Eg2mg1dni197sA+GchB06ZyeVS27fuyoyVHB/mRR9S4cxe8PmfM0Ixhqhmp8sfP9
         4G2ALE5QASuZgFInVqgTlOst66aZafWoZWOjh8ZY9E7O218sNSfR1UC5po1N4fsZOMIQ
         NSqL9gUwNHMEVxO9v42aRU2y0uDQdRUZ4gAU5kgouQ3YedL0ryTFnm522StBdBcgyOpE
         PPMg==
X-Gm-Message-State: AOAM530xkk67ozPU/OhcKdVnYqabgAvWgrsEmFKCsu7YQ3jxim/fk4EO
        RoyETrupU+ntEfWGJNykRIQEKQ==
X-Google-Smtp-Source: ABdhPJwIJ3xyCobBIKm11NdjZ/0cHa14ppw52DCxQ1fSO36R2Nv1XF81abDAdbPQx7gRIUbSX5vtjA==
X-Received: by 2002:a63:950f:: with SMTP id p15mr5103786pgd.265.1634832159821;
        Thu, 21 Oct 2021 09:02:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm6419924pfn.136.2021.10.21.09.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:02:39 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:02:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 01/20] exit/doublefault: Remove apparently bogus comment
 about rewind_stack_do_exit
Message-ID: <202110210902.40730E333@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-1-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:47PM -0500, Eric W. Biederman wrote:
> I do not see panic calling rewind_stack_do_exit anywhere, nor can I
> find anywhere in the history where doublefault_shim has called
> rewind_stack_do_exit.  So I don't think this comment was ever actually
> correct.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Fixes: 7d8d8cfdee9a ("x86/doublefault/32: Rewrite the x86_32 #DF handler and unify with 64-bit")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
