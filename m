Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2650436804
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhJUQja (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQja (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:39:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51889C0613B9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:37:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m14so1120920pfc.9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G1W8DTLADl2GUsD/EeqJwszAFiOdaJxD4ztTzHDSy5M=;
        b=OG65M2WSCpME2vcPnPXj57WCIAg0ssDQeEW9RvrP9+eylnQoQidHcjUlMay8hkaXjp
         OqaiBrgj/gMKNwCq2jQfnM022acVFvkdG4MYlrgUGW/qEd4oZGEp2Ue+rjATMZZKz8T6
         xofMnArbm/9GIjTnFzXFiFfeq7c3LPBnpvNOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G1W8DTLADl2GUsD/EeqJwszAFiOdaJxD4ztTzHDSy5M=;
        b=HqoGQLqH9Mf5H/rQDb0Aw4gfqWEI3dP1wJJNqtPfnt+QWGL5E5JJYEEpmgyjSwdEPV
         cVn6pTdcih2LOzvSHvOH3lrC5+EWgB/cZIEPjqBNWLj101JO8eYNQfd7yy+kWjQ8ldL9
         CXKDH+nQ8ZkWVjm3yBLyC6tPmwRUdd0HGXs2XFZeUJy2Obc++3DiGxqn9UNl15H+suia
         pqopvAlaL2kIwxKjikDWZahU/cWJKORA5bYk3t8Lq/w3pEIXiWbze5hsmQQIIhm0epdh
         rDsVHm4T/XzlLd45+XBN1lrCIh6YJy/PtGOZ4uuNImwDyVgPgmA5teM0I4DLxw0zPZuG
         +Ujw==
X-Gm-Message-State: AOAM532MI8GlSormC+25TnBd0fhBFbRcrM6ICSx0QBC/wVU79JDSrf6r
        I08v5b39MiXGDd5eCFFHSJn95Q==
X-Google-Smtp-Source: ABdhPJyDYCYZKWf7JcYUwoBaiCmk/YTntQnZc+hEdmWdYm/Zl76od7Li/vt07lAaCoRrlj67dnB/Gw==
X-Received: by 2002:a63:258:: with SMTP id 85mr568520pgc.411.1634834233904;
        Thu, 21 Oct 2021 09:37:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m22sm5650349pgc.64.2021.10.21.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:37:13 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:37:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 18/20] exit/rtl8723bs: Replace the macro thread_exit with
 a simple return 0
Message-ID: <202110210937.B3C164A41B@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-18-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-18-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:04PM -0500, Eric W. Biederman wrote:
> Every place thread_exit is called is at the end of a function started
> with kthread_run.  The code in kthread_run has arranged things so a
> kernel thread can just return and do_exit will be called.
> 
> So just have the threads return instead of calling complete_and_exit.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
