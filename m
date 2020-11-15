Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB512B37E0
	for <lists+linux-arch@lfdr.de>; Sun, 15 Nov 2020 19:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKOSfz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Nov 2020 13:35:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36400 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKOSfz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2020 13:35:55 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605465353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anm5dflcALDEl10nSUL87cp/zivIAPJR1id9Mr69p9o=;
        b=NShRjNRIBCGeSMMBw8XvaSEO3XpsdNPG3ez9vkEs8dTbN0kQCSptOLXAif51Ah9fguDoVk
        7t7xeabjmh+MnGe9tmDNSrMzxu3EHAn7LIaHifs3QaBydgNFSQ3i04dEsFErJFBkCVsmEB
        mm+0Q2gHinuoAxN45TQRF9GS8mm3aVdCgOqbkUGiVpemt/1e8cLHI+j2ik1xhFLXNe/h5n
        e72eynPimqqp9+ekorJnUxwwGJnuVrtEDOTBVAFJo4yao2yrh/cXGEtRCFx8EpnM1aDmMd
        MQLFSOY7X54dFOjfVZ8tsVuEF2jJ8yTmQR5D58wSI/imKRy0OtD+OvmBsDonOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605465353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anm5dflcALDEl10nSUL87cp/zivIAPJR1id9Mr69p9o=;
        b=fOWzK/LR7JTAH7B1xOZSD4L6kGGVJZxb+FbYhM7O3wBQc7o8IjzzeMGZDPPpzubu4O/rHz
        GY705EuLYG1cBWBg==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 04/10] seccomp: Migrate to use SYSCALL_WORK flag
In-Reply-To: <20201114032917.1205658-5-krisman@collabora.com>
References: <20201114032917.1205658-1-krisman@collabora.com> <20201114032917.1205658-5-krisman@collabora.com>
Date:   Sun, 15 Nov 2020 19:35:53 +0100
Message-ID: <87y2j28o3a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13 2020 at 22:29, Gabriel Krisman Bertazi wrote:
>  
> +enum syscall_work_bit {
> +	SYSCALL_WORK_SECCOMP		= 0,

enums start at 0, so why do you need an explicit assignment?

> +};
> +
> +#define _SYSCALL_WORK_SECCOMP BIT(SYSCALL_WORK_SECCOMP)

Do we really have to repeat the nonsense from TIF/_TIF in the naming
here? Can we please name this in a way which makes it obvious what is
what?

Thanks,

        tglx
