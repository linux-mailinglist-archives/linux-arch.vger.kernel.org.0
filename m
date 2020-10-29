Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6303429E01D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 02:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbgJ2BHm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 21:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404126AbgJ2BHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2020 21:07:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51350C0613D5
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2020 18:07:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x6so1301339ljd.3
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2020 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JHdZPPn9wLM8C261Oo5ewV1obQFhVZ5ZdtkoajBWV64=;
        b=MTIV5nTARTLRBj0lxrRgSzGzRPYNAiPZWMkB9ep/3PqQq96Sbvp39GhCCvD9P7C/9G
         jSa0WHMFFRSKIlGXwo17x9mJaZSXNA2WyNRoeARNazqPz6DjPLBNsihFZKJM4DFVZ/CQ
         j3PNJYC6TnyMC9tXn4jy59H788ukVUiTCREIlCJtFaO+tL4gtg47eg+1qCzJX2qAaGf0
         OGl7m75eU0hiHajz8+lj34XqRRj/KyofTQfSSo0wWrl+kguZAe7y41ED4NaXCYy9qrEK
         VBXAJUcNjw8AKl3YDslsCgKie01Tu2Qs1ciqvcEbb3HuzunIQUzDI9drOA7XrORLRfmD
         yjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JHdZPPn9wLM8C261Oo5ewV1obQFhVZ5ZdtkoajBWV64=;
        b=msQsiIni/HPb7x/d+gVAG/hUaACOXnNUJxwlV6GoemHY1Ky3aW2uuGtPccFIANuQVV
         0KUmJXI4Rx3/Mbxt1MSfamlxssZAEv4b5bCL/khOoFcCu/3D9k67j+x8Xp6guf5GGrg2
         r9T7XXTjQLJe+P15QGfZqk7c69Qm1rJOWRLcCrchPrsA5shbO0pFNLfIO01L5TtLMKfN
         RVsK3XoClGgpMQvdZeIPC0QwR6r9U8qpKvGScO5WaXYDCFzpgbPnQ+KLD3mITibnWnqw
         QiykmCCuslDB4CvfdjFbRVgl9Wj53tLTr0f/JoQ9DSc7Hc3AAAXm2YBH7GcV12JZGCJ8
         1WdQ==
X-Gm-Message-State: AOAM531m3DCt9SzzBWaWU7xKYRxqARzm98+yuSuCdo/Pp9I/JkgZ5+Bb
        hhRxf6ojULSuM6nVdLhuL/Dxy+QyVKH0AnVgZK3v0g==
X-Google-Smtp-Source: ABdhPJxZF2osDmUJJYFjNdSuFzFlSzMFSQ07MX9iBFABKWDfUCx38EmD5usneiPJrsJhn41DKD8OlPb4Di5oSfLsrWI=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr663617ljh.377.1603933658573;
 Wed, 28 Oct 2020 18:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-13-mic@digikod.net>
In-Reply-To: <20201027200358.557003-13-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:07:11 +0100
Message-ID: <CAG48ez07p+BtCRo4D75S3xsr76Kj_9Aipv3pBHsc4zyNjEiEmQ@mail.gmail.com>
Subject: Re: [PATCH v22 12/12] landlock: Add user and kernel documentation
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

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> This documentation can be built with the Sphinx framework.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
[...]
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
[...]
> +Landlock rules
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A Landlock rule enables to describe an action on an object.  An object i=
s

s/enables to describe/describes/

> +currently a file hierarchy, and the related filesystem actions are defin=
ed in
> +`Access rights`_.  A set of rules is aggregated in a ruleset, which can =
then
> +restrict the thread enforcing it, and its future children.
> +
> +Defining and enforcing a security policy
> +----------------------------------------
> +
> +We first need to create the ruleset that will contain our rules.  For th=
is
> +example, the ruleset will contain rules which only allow read actions, b=
ut
> +write actions will be denied.  The ruleset then needs to handle both of =
these
> +kind of actions.  To have a backward compatibility, these actions should=
 be
> +ANDed with the supported ones.

This sounds as if there is a way for userspace to discover which
actions are supported by the running kernel; but we don't have
anything like that, right?

If we want to make that possible, we could maybe change
sys_landlock_create_ruleset() so that if
ruleset_attr.handled_access_fs contains bits we don't know, we clear
those bits and then copy the struct back to userspace? And then
userspace can retry the syscall with the cleared bits? Or something
along those lines?

[...]
> +We can now add a new rule to this ruleset thanks to the returned file
> +descriptor referring to this ruleset.  The rule will only enable to read=
 the

s/enable to read/allow reading/

> +file hierarchy ``/usr``.  Without another rule, write actions would then=
 be
> +denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with =
the
> +``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with thi=
s file
> +descriptor.
[...]
> +Inheritance
> +-----------
> +
> +Every new thread resulting from a :manpage:`clone(2)` inherits Landlock =
domain
> +restrictions from its parent.  This is similar to the seccomp inheritanc=
e (cf.
> +:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task=
's
> +:manpage:`credentials(7)`.  For instance, one process's thread may apply
> +Landlock rules to itself, but they will not be automatically applied to =
other
> +sibling threads (unlike POSIX thread credential changes, cf.
> +:manpage:`nptl(7)`).
> +
> +When a thread sandbox itself, we have the grantee that the related secur=
ity

s/sandbox/sandboxes/
s/grantee/guarantee/

> +policy will stay enforced on all this thread's descendants.  This enable=
s to
> +create standalone and modular security policies per application, which w=
ill

s/enables to create/allows creating/


> +automatically be composed between themselves according to their runtime =
parent
> +policies.
