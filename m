Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216E9436770
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhJUQT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUQT6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:19:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BFC061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:17:42 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so745769pgl.10
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1qArqukqC04HeUCYKid9OyPBNl7BXFoMkpeHaeZAIfE=;
        b=SHGLjN129sDYsXEBOsuAe2uP97qJsPaTNPpHcXnbmGFyxoRGDwinnb1n91ZKRtwq0T
         /0qtzTcOqWpoPeP/6byc/5SC7lY+NYraLtivcQxalcJ2dEXztutjP3B98tUY6U3ef9sn
         44aXRzM7rk3gagysuq2S3rcmAKD0sRkUoCjWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qArqukqC04HeUCYKid9OyPBNl7BXFoMkpeHaeZAIfE=;
        b=miTZD+xxlYX2R4F45lHeQnXW3+nKuMOKPKbVx5iwagAHjbApnqMb6QExsZi9tiELdk
         3N+Rtb0ptOX4TNGBJLBvOYxRygThB9O3OSkg0qVFmi+vk15KLxSdGiWPMc8qggVyhljh
         i8DMPc62LZuoXAn0ebg2eI+K3k12LfyIhuW+WAh350xjTDM+ilHGNzZKTgLVj6DcMquN
         DAsKfYdk4OEDbvhq95fEwLg9OWUW2dOkdIBVg5v7xLmWSW7s1XppG6cAwav750QbpEcP
         lDV4ZfRrGukxOXfXAirTQAIfyjQ7anayXjp9sJ/L/taoNkCf3I/UqrDO87AIDakr7MX+
         R/fQ==
X-Gm-Message-State: AOAM5339kyfwPztBcKFoGRhXku7UsdxNElNnPvumpUMe7VusQZXBczaX
        ymVs/cTTZV7nwP7CRjEzLYDq+g==
X-Google-Smtp-Source: ABdhPJxhDUv0mfKcvT4mC7bIBo7ygrswSSyc5PmTDnjtOjwpsfgOMJolqsotzki3s0E2t66fUJIsWQ==
X-Received: by 2002:a63:d94b:: with SMTP id e11mr5038268pgj.295.1634833062183;
        Thu, 21 Oct 2021 09:17:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8sm7153670pfn.45.2021.10.21.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:17:41 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:17:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 11/20] signal/s390: Use force_sigsegv in
 default_trap_handler
Message-ID: <202110210917.FEED0F8@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-11-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:57PM -0500, Eric W. Biederman wrote:
> Reading the history it is unclear why default_trap_handler calls
> do_exit.  It is not even menthioned in the commit where the change
> happened.  My best guess is that because it is unknown why the
> exception happened it was desired to guarantee the process never
> returned to userspace.
> 
> Using do_exit(SIGSEGV) has the problem that it will only terminate one
> thread of a process, leaving the process in an undefined state.
> 
> Use force_sigsegv(SIGSEGV) instead which effectively has the same
> behavior except that is uses the ordinary signal mechanism and
> terminates all threads of a process and is generally well defined.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
