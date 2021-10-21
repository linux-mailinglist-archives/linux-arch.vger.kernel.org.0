Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66199435B4F
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJUHJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 03:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhJUHJF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 03:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D04A60FC0;
        Thu, 21 Oct 2021 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634800010;
        bh=hs2snseJ8YgIckgi0bMl5NvKTp+MmQDXvrHOzNnxggw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wECbXX7eLZCGcygaG3znjjgWk0TBC6UxRvOqUsCc9efS0p7Y4NqvQAiwRoewFo//W
         o1xyyI5RsqaNdjsqVd7w15ePpoAggRNWF++tegglKG9DtLbH7QgS3bnBsyb5LYEVcw
         7YKl01FZ0SWETmx32hSn8uxEe+6osnhe7NHmh0Zk=
Date:   Thu, 21 Oct 2021 09:06:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 18/20] exit/rtl8723bs: Replace the macro thread_exit with
 a simple return 0
Message-ID: <YXERhzKOVzGJoNMN@kroah.com>
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
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c                | 2 +-
>  drivers/staging/rtl8723bs/core/rtw_xmit.c               | 2 +-
>  drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c          | 2 +-
>  drivers/staging/rtl8723bs/include/osdep_service_linux.h | 2 --
>  4 files changed, 3 insertions(+), 5 deletions(-)

You "forgot" to cc: the linux-staging and the staging driver maintainer
on these drivers/staging/ changes...

Anyway, they look fine to me, but you will get some conflicts with some
of these changes based on cleanups already in my staging-next tree (in
linux-next if you want to see them).  But feel free to take these all in
your tree if that makes it easier:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
