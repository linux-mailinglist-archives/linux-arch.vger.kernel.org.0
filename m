Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97079436782
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJUQXf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJUQX0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:23:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E3CC061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:21:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h193so797258pgc.1
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jg0yFOBM6A3SUVt+DqbY2wqTKm8dNMRFRdU+uWfyi3I=;
        b=JektROTBBl7Hp9hpBj4QdneIc7ajfIFDeFyhlpcUVEK3Hd3whA4vy6neIFWPGZS7ka
         Fu5//cKCFmGvv0PlC3E4YVPU7QCkV53Aqe3PTylOR8bfd9vwT39QIK1wHlW8kA+eWwrR
         P7OIe0wra40Oe8AxPoY5I6uNJFQ80lqtyaPIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jg0yFOBM6A3SUVt+DqbY2wqTKm8dNMRFRdU+uWfyi3I=;
        b=dCJ1x4VV/wi5OZT8WHvlQfkj36Oi42wZ5t27YDnOozCrVMnkjn6IKEFZ6Tszl/DlCS
         6qevtIHObUyuFWUjpAQWAIrjyTQynsIL1tmeB6KdteSxvXWL8F3DekPNUOXhg3+YqV26
         w45SoxvfMlma2mdwQH0lE51cY3ZmnsHRGzfsMiZU87rN0A91HQEt90UJVDduGLrB7X/W
         WnS4n0g1Jm2EkQFk54ZxEvk92sr5FAeEs7oydj59OruFIes3ysDdjvm9DSpQ6zoHBbRB
         igMGSqn6wrGMDhrnDQPDyTZqB/WZI1zLt+MK438AjXt6t/j66lB44s1v8hmkx38mCDUl
         HONA==
X-Gm-Message-State: AOAM5307mm4Af9vzY52Kvs0Fn9/l9mB4XSGferB/V4LKutHZ0kO1aBa1
        zgf7ctqkanf7HRoyk47pgFL+5qXMO3mw7g==
X-Google-Smtp-Source: ABdhPJxc3JF+nJUBXFnmK+UT96OkEJQMZ4SJBBtiW9zggzhWTQoM3Qy9GF+MDzU9VGmzgpIbG6sVqg==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr5152395pgc.97.1634833268246;
        Thu, 21 Oct 2021 09:21:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k14sm6131525pgg.92.2021.10.21.09.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:21:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:21:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 12/20] exit/kthread: Have kernel threads return instead
 of calling do_exit
Message-ID: <202110210920.3D47EC5@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-12-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-12-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:58PM -0500, Eric W. Biederman wrote:
> In 2009 Oleg reworked[1] the kernel threads so that it is not
> necessary to call do_exit if you are not using kthread_stop().  Remove
> the explicit calls of do_exit and complete_and_exit (with a NULL
> completion) that were previously necessary.
> 
> [1] 63706172f332 ("kthreads: rework kthread_stop()")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks sensible. Can you check that tools/testing/selftests/firmware
still passes? That test does a fair bit of kthread waiting, etc.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
