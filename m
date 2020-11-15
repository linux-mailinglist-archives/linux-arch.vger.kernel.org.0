Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25F32B37F0
	for <lists+linux-arch@lfdr.de>; Sun, 15 Nov 2020 19:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKOSl1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Nov 2020 13:41:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKOSl0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2020 13:41:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605465685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=st+LPe0l/8Cyy7A2qdTz+FX3+RRK0D3+tIauUcTuJEg=;
        b=ES9Hx1VFAVUcvXp8y/O4jR9GSod9a4EwTxfqKxHCQ7eHcmsvuRh2gf6GIYaB8oS4szfijy
        vHMXARJBKkE6eHeGgnyQQPbLReQjaEmgbEgBij3IiPRvpDcte2BYiLG66Y3ixQ0ei/O3Kg
        NOxdE0QCe4o+cVGVJzXUzY/k60Z+D30gm4gt/z4caSnktmiULSLdPVgwZk/KSe1XywZFYI
        oNxjJfFnsp9XZPLsCATsGAC+q+AEorBaIZh4+TiMGJgezdIRuUZOxjKZLlYNN0ub61UTyk
        DAaPovd73JaEcJ/6uWHiJ2dqfOvtR3q7Z2m2prfDQm712TXaC5rs5+sZ/OTQCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605465685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=st+LPe0l/8Cyy7A2qdTz+FX3+RRK0D3+tIauUcTuJEg=;
        b=jbPkrzO4qWM320LAUpNz7at7C9nn9s76rvttNqFxVPnw4LudD2FGLsvtfaH5rHt2CmaZAY
        3eTX4g1i+hHM5LBw==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 05/10] tracepoints: Migrate to use SYSCALL_WORK flag
In-Reply-To: <20201114032917.1205658-6-krisman@collabora.com>
References: <20201114032917.1205658-1-krisman@collabora.com> <20201114032917.1205658-6-krisman@collabora.com>
Date:   Sun, 15 Nov 2020 19:41:24 +0100
Message-ID: <87sg9a8nu3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13 2020 at 22:29, Gabriel Krisman Bertazi wrote:
>  
>  enum syscall_work_bit {
> +
>  	SYSCALL_WORK_SECCOMP		= 0,
> +	SYSCALL_WORK_SYSCALL_TRACEPOINT	= 1,

No assignment required. Enums just do that for you.

Thanks,

        tglx
