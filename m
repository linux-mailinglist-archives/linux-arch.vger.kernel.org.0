Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4929DFFF
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 02:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgJ2BHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 21:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404152AbgJ2BG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2020 21:06:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A305C0613D2
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2020 18:06:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so1264290ljj.8
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2020 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sdW8glxlqT52o6OrX86F7zpNSSHvHFcM+yTkw93QmvU=;
        b=OQFoy5zJcvGaPYRjULm9FRQ4mPpGgZUmLkSBusyWrqN7wYA6OKMhtdFCj7k6mxGVVn
         /OB6g0MYcj16bI3y0RZAnTaIqfzbpgMOw5XGd4GR3BPNbqmLRVZfrNgeih5y59Ukq7m8
         hQ2JsWLBe5/8kwUHrYWzO15rATBwrSZSug26Qn738s0cmusMvscNdYWrEyDFeIIxigX/
         djhhUiRssu5Q15Vhx6qIjm2Ox/u4rrcbzo4r3H7eYiBYzRqiKzLmUsoc0+Jsbge3+k21
         5yjSQlazLmxu+Kte6xds9kyAl4e/NpD7HFcpW0zVmKkL0FHCl8jErMGvQv9yJe4Z5ez9
         yF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sdW8glxlqT52o6OrX86F7zpNSSHvHFcM+yTkw93QmvU=;
        b=nS3rdvrwVkoqnQ8uXKxk0p3YkfLx/ML2PJxtCLKNWQBgFLFZphhZCNY3J0G5PNPOFU
         qS1XcWy0nfPAHrP6xB9nGJqXqme6xl+gywSTLFIJ6Frwi1erKf4hxD7pd8n1N9lpE8u9
         pSakjHHNqE43NOeOf/qNAYYvXIxw0yG51yX/2aU9BB9KJkHsWaqG0yJqvBqf3Qbsp61q
         NqptJp6131/1SqFpVGohoZmwMyGbz0YWDlsCG9wGk1fOwCwdJuRxQXIcIc8fLkL1LM3c
         LIILqaJ9tmeTaPupZ3MeYRCCRNYO8xMyjcwBZQcrQTqI+iWATjQlB9zSpIqoSfnFhUpr
         vaMQ==
X-Gm-Message-State: AOAM5306+dJuxjchtZfExlrcysFcEUfo2tCUKT2UsnWfBRwnwiysBqy0
        AqogA14HvgoJYFBFa9Co/UiI/qZ0zB9VxeyV1gExgA==
X-Google-Smtp-Source: ABdhPJzyyZaaLe2JA3VvgL7cUtSj9LlNwA65qJkm7Fv1qbvcq5QSy/4U16ih92Ck7/3Dyb1x1IAYXE/2zulh7bsAAQY=
X-Received: by 2002:a2e:b888:: with SMTP id r8mr712081ljp.138.1603933586611;
 Wed, 28 Oct 2020 18:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-4-mic@digikod.net>
In-Reply-To: <20201027200358.557003-4-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:06:00 +0100
Message-ID: <CAG48ez2idPLmoQmqi5SL-kL1B=3W4LBAEc8r7oUp2J9SxTr1rA@mail.gmail.com>
Subject: Re: [PATCH v22 03/12] landlock: Set up the security framework and
 manage credentials
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
> Process's credentials point to a Landlock domain, which is underneath
> implemented with a ruleset.  In the following commits, this domain is
> used to check and enforce the ptrace and filesystem security policies.
> A domain is inherited from a parent to its child the same way a thread
> inherits a seccomp policy.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Reviewed-by: Jann Horn <jannh@google.com>
