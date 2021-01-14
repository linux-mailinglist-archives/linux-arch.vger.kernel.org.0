Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD22F5941
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 04:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbhANDXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 22:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbhANDW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 22:22:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C890C061575
        for <linux-arch@vger.kernel.org>; Wed, 13 Jan 2021 19:22:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b26so5994498lff.9
        for <linux-arch@vger.kernel.org>; Wed, 13 Jan 2021 19:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dCFQaFfNvbuO5HY7Z7A4y6PDjNP/mJF+eUt08nNpgNw=;
        b=qyR3yKeVlSVD4nXEr5DNwY3hTrpmi4Gpaollqr/lgV2pXEOq2Hp+DRUQf9MfHkB7oI
         uUHC1ag3mrzR3YcISx5SW09OG6EQ/+tvGiBegOCy0ZlQ0f0BKH/+M2V/NQeklOddlLGC
         nzeh+16Fq9IJ8T9EU3QDHHQjmr9e2/+IJZAtkRUK0q8rH9AlxVcK3jQEeOexfiT2UwDI
         y48ANh+Nrq7aYwuYfnWWzGIQezATsDthxYwmDAAsrd+aL5fKnC90hK5CZnKOoz57UZnd
         4lO5Igd+CQ+DYaOYb7DvEo0gJX1hVR0HaeMR0NNuKfGu/hLMcAy5lZwbkQY0/vIYRH9V
         NdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dCFQaFfNvbuO5HY7Z7A4y6PDjNP/mJF+eUt08nNpgNw=;
        b=hpm9LjkZvJchY4UHq9t5Tv2nbay63Q1mhDxLr4elsSzhRWZwDaRs68vmDVmDmXE7wI
         E9LA4R7gHJCKzZTXnADjkPvgtd9PTwC7PDfIhcVubKZybQOE/i/9WY4Pf0cHYb7QoO9R
         NCcBCqtI+Q9JSy+wHf88PmiSYIA9BdC+cEXnJv+VV2KVKOzj7TLWVEqBWpD4pQhfzvnT
         gH029MKMGJM3mIY72OllgJJGp9DGATz9LWwWHWmhHCp2aiBwI0+NsnjT79SM1RULOc0U
         tx+bH0mYmBVP1rEDpAtPxiSIOLPQhKPYCsYMjWZT0ghgPm0A8GvSMItJt+HBQCstHHvl
         yFzA==
X-Gm-Message-State: AOAM532uhoApzQb3scbf+POtMRlPKfNp0/LJ6s4jZnnUUSHZL+qqtbw2
        4gr33jIo0PvCpSatiEtKbGj8Awx3y6kWaxav9vL/4w==
X-Google-Smtp-Source: ABdhPJy2ztIcgirLsCEUZr5FnJ2w/fpVqYharZIkGROnhebDaGtH8MuCSMe/CMNAjqxgsTr84sdizdyn5x4MIXGZMZ0=
X-Received: by 2002:a19:197:: with SMTP id 145mr2241268lfb.352.1610594530449;
 Wed, 13 Jan 2021 19:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201209192839.1396820-1-mic@digikod.net> <20201209192839.1396820-3-mic@digikod.net>
In-Reply-To: <20201209192839.1396820-3-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Jan 2021 04:21:44 +0100
Message-ID: <CAG48ez3Kf-jR2jhoyU29oad3-1R-BdO73hpfPeXwaaPzPK8Y0A@mail.gmail.com>
Subject: Re: [PATCH v26 02/12] landlock: Add ruleset and domain management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 9, 2020 at 8:28 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
> A Landlock ruleset is mainly a red-black tree with Landlock rules as
> nodes.  This enables quick update and lookup to match a requested
> access, e.g. to a file.  A ruleset is usable through a dedicated file
> descriptor (cf. following commit implementing syscalls) which enables a
> process to create and populate a ruleset with new rules.
>
> A domain is a ruleset tied to a set of processes.  This group of rules
> defines the security policy enforced on these processes and their future
> children.  A domain can transition to a new domain which is the
> intersection of all its constraints and those of a ruleset provided by
> the current process.  This modification only impact the current process.
> This means that a process can only gain more constraints (i.e. lose
> accesses) over time.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Yeah, the layer stack stuff in this version looks good to me. :)

Reviewed-by: Jann Horn <jannh@google.com>
