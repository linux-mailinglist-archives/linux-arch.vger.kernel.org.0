Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A693C435B54
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhJUHJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 03:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhJUHJi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 03:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6D3A60F5D;
        Thu, 21 Oct 2021 07:07:18 +0000 (UTC)
Date:   Thu, 21 Oct 2021 09:07:17 +0200
From:   Greg KH <greg@kroah.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 20/20] exit/r8188eu: Replace the macro thread_exit with a
 simple return 0
Message-ID: <YXERpYKdDpvGej7z@kroah.com>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-20-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-20-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:06PM -0500, Eric W. Biederman wrote:
> The macro thread_exit is called is at the end of functions started
> with kthread_run.  The code in kthread_run has arranged things so a
> kernel thread can just return and do_exit will be called.
> 
> So just have rtw_cmd_thread and mp_xmit_packet_thread return instead
> of calling complete_and_exit.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
