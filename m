Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2F307643
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 13:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA1Mlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 07:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhA1Mli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2021 07:41:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09457C061573;
        Thu, 28 Jan 2021 04:40:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611837656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdL08PANt5lOJIaa1SXHJ/bcaxO9ZwWzdQp+AJxzmz8=;
        b=yXC4wRtS7PDNgBGWbuXT0WiBs5yqlJri+pmDr22MYkh3Dt7RpSoRYfU3eh/2bxRb/nC1zr
        5NRgXT9GDykwsmIV5NYF4JhuXDHrKQzzhKTfoZahv3KkSLlTQm2u6zUI2NXH2hve8+JCvb
        UdzD0rjm/KpJ9YeUdZJfBAXtn1Ws1weV4EW6JSeHaTa+e8uo5AcefQnXDWOfb7gPk91KS/
        4+Ai+RHYK1Ge4pSVxu4UH+o9j4bndAxBar6wbsuG6MbzQ3aIYhAyuwtvMXAHRIuwsT6IvQ
        iV6wFkwpAq33L9I2FHxTHsihE05U4LJnAMWaxwgVDqV3xUQoI3h4ALL0xtM0pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611837656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdL08PANt5lOJIaa1SXHJ/bcaxO9ZwWzdQp+AJxzmz8=;
        b=OJTu5wBy0d6MeFjN9/PNJyFh42klXfVwQbxCbSZspgsAiQI81hO+Y4oj/oipAXeAS+1WnG
        fhMwzuJfdqszoXCg==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Yuxuan Shui <yshuiv7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel@collabora.com, x86@kernel.org
Subject: Re: [PATCH] ptrace: restore the previous single step reporting behavior
In-Reply-To: <87zh0u540n.fsf@collabora.com>
References: <877do3gaq9.fsf@m5Zedd9JOGzJrf0> <87zh0u540n.fsf@collabora.com>
Date:   Thu, 28 Jan 2021 13:40:56 +0100
Message-ID: <87wnvxcjzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27 2021 at 20:55, Gabriel Krisman Bertazi wrote:
> Yuxuan Shui <yshuiv7@gmail.com> writes:
>
> To gather the right attention, you should directly CC the correct
> maintainers.

You could have cc'ed them on your reply ....

> Fixes: 64eb35f701f0 ("ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag")
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
