Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86098351E1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFDV3f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 17:29:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33957 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfFDV3f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 17:29:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so345486wmd.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Jun 2019 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZJYTNyCIjCtE1t89164f4VdEMlbutgxwjEunlEpUIs=;
        b=WZ9Fg9ddza4LB6asPBDF7sIrW37u5T5YUWWbvHtVVmMwyWIDe8KCQCJoLw4YFIRNvR
         PBDGPZ3P2cHPq6pwX/Dssuy8C+eM/vg9nT6qAQeAiZ0gXshdzz+2nYzur5jVPDMZAbKT
         dT66uq6ltvKrEviKKbhQBrERGzP8jJWUGZMLaGxWcWXxmoWSy/xGP8vA4oo0yTFWGXhK
         HjksfSXEcnmpLhrf/hle3rBr7DxBHcFJT78iI8p61BBgSX2SsMBdx9+39JdBrI8451qL
         u2HvXTEOdcLVa5Pq5zvrZWVCMuR6mpvm0983zyu6+oQfxTvbm4yb09moe03txqhc5aHQ
         VJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZJYTNyCIjCtE1t89164f4VdEMlbutgxwjEunlEpUIs=;
        b=F1F+l6L3H/aatZMEnghlfWDgBKG49mymqzlqJ7gD8luhw/XbQaoNOHF/Kjc/hklFny
         7fjD744+WT0n0g10IOBjg8cDPlmX8y77BIGqL+7toQXGv5MyN2UqzxgHFz8ZBOmMkCTp
         JOqwtu18BqWNl0vyOM8ctGcG73pJ8ymlzW4YfJgCWHunUY32rkBzYvHJ0rZtmhMlAHzj
         /1oIX9yneYWLfERhZmZxJwMIcdGa4JTe9C//3Vd4RnSH4nozE695E195ZT7KeIb9prtN
         M9V+M+ie6JBKMjMNvv9/3q6s01AaPVY8kdVlb0rG3rlFv2z4PpZSJAsQnM9Bm5VYbbrO
         W/QQ==
X-Gm-Message-State: APjAAAWkUDjmIr/+rALmSL8GygvTadA9INk2jAdMvOOAgUnfrS1rnnXt
        +8XcANTE1PK3+TQh59O429oO49ufMoV9CQ==
X-Google-Smtp-Source: APXvYqzVsE3k85yIa2SJX8wP8sQoi4ubyYz/yHbAoIOdCtMJMaJLOOGxq2nRFaSspruhOGlWd0ZP6A==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr8157160wmh.132.1559683773365;
        Tue, 04 Jun 2019 14:29:33 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id x11sm14812487wmg.23.2019.06.04.14.29.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 14:29:32 -0700 (PDT)
Date:   Tue, 4 Jun 2019 23:29:31 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
Message-ID: <20190604212930.jaaztvkent32b7d3@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <CAK8P3a0OfBpx6y4m5uWX-DUg16NoFby5ik-3xCcD+yMrw0tbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0OfBpx6y4m5uWX-DUg16NoFby5ik-3xCcD+yMrw0tbEw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 04, 2019 at 08:40:01PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 4, 2019 at 6:09 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Wire up the clone3() call on all arches that don't require hand-rolled
> > assembly.
> >
> > Some of the arches look like they need special assembly massaging and it is
> > probably smarter if the appropriate arch maintainers would do the actual
> > wiring. Arches that are wired-up are:
> > - x86{_32,64}
> > - arm{64}
> > - xtensa
> 
> The ones you did look good to me. I would hope that we can do all other
> architectures the same way, even if they have special assembly wrappers
> for the old clone(). The most interesting cases appear to be ia64, alpha,
> m68k and sparc, so it would be good if their maintainers could take a
> look.

Yes, agreed. They can sort this out even after this lands.

> 
> What do you use for testing? Would it be possible to override the
> internal clone() function in glibc with an LD_PRELOAD library
> to quickly test one of the other architectures for regressions?

I have a test program that is rather horrendously ugly and I compiled
kernels for x86 and the arms and tested in qemu. The program basically
looks like [1].

Christian

[1]:
#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/sysmacros.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <unistd.h>

static pid_t raw_clone(struct clone_args *args)
{
	return syscall(__NR_clone3, args, sizeof(struct clone_args));
}

static pid_t raw_clone_legacy(int *pidfd, unsigned int flags)
{
	return syscall(__NR_clone, flags, 0, pidfd, 0, 0);
}

static int wait_for_pid(pid_t pid)
{
	int status, ret;

again:
	ret = waitpid(pid, &status, 0);
	if (ret == -1) {
		if (errno == EINTR)
			goto again;

		return -1;
	}

	if (ret != pid)
		goto again;

	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
		return -1;

	return 0;
}

#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
#define u64_to_ptr(n) ((uintptr_t)((__u64)(n)))

int main(int argc, char *argv[])
{
	int pidfd = -1;
	pid_t parent_tid = -1, pid = -1;
	struct clone_args args = {0};
	args.parent_tid = ptr_to_u64(&parent_tid);
	args.pidfd = ptr_to_u64(&pidfd);
	args.flags = CLONE_PIDFD | CLONE_PARENT_SETTID;
	args.exit_signal = SIGCHLD;

	pid = raw_clone(&args);
	if (pid < 0) {
		fprintf(stderr, "%s - Failed to create new process\n",
			strerror(errno));
		exit(EXIT_FAILURE);
	}

	if (pid == 0) {
		printf("I am the child with pid %d\n", getpid());
		exit(EXIT_SUCCESS);
	}

	printf("raw_clone: I am the parent. My child's pid is   %d\n", pid);
	printf("raw_clone: I am the parent. My child's pidfd is %d\n",
	       *(int *)args.pidfd);
	printf("raw_clone: I am the parent. My child's paren_tid value is %d\n",
	       *(pid_t *)args.parent_tid);

	if (wait_for_pid(pid))
		exit(EXIT_FAILURE);

	if (pid != *(pid_t *)args.parent_tid)
		exit(EXIT_FAILURE);

	close(pidfd);

	printf("\n\n");
	pidfd = -1;
	pid = raw_clone_legacy(&pidfd, CLONE_PIDFD | SIGCHLD);
	if (pid < 0) {
		fprintf(stderr, "%s - Failed to create new process\n",
			strerror(errno));
		exit(EXIT_FAILURE);
	}

	if (pid == 0) {
		printf("I am the child with pid %d\n", getpid());
		exit(EXIT_SUCCESS);
	}

	printf("raw_clone_legacy: I am the parent. My child's pid is   %d\n",
	       pid);
	printf("raw_clone_legacy: I am the parent. My child's pidfd is %d\n",
	       pidfd);

	if (wait_for_pid(pid))
		exit(EXIT_FAILURE);

	if (pid != *(pid_t *)args.parent_tid)
		exit(EXIT_FAILURE);

	return 0;
}
