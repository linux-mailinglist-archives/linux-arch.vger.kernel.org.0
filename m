Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910AA6A92B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfGPNGq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 09:06:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33771 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbfGPNGq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 09:06:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so9107573pfq.0
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2019 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HndzIrwk0eloZ/VKZJ3ivaH1s8315qlKpsro16xZw70=;
        b=b8dhUBZSz3RGMnHXa2eQUBcpb0Fr1c6vhDDwn4sy14RwoF3LeMqo4GwVei/eUCKLfN
         2ysAKK0S6zo65plaT8Lmyu1cdKbX5vv5C3GPTJPIInad+mBHinkOAREnbCNuxmpL9VDG
         fvZUIwNFnzQNqEmzHkL0RRQ1MQkDpVZLaNNcaAVC/zAYUxremZf5+M3FMQbomiyN3wH4
         zc2zC/xff3jM5dpplZUlTKdEFImIprhxsju27ez6MU1i0OsgFNq72UzfzJW9Togr4CqO
         YkkRxSa2wlAwsL/E0oFuYOap/7lvKcKnsDSBvmk5MITFO2BYwQSiCBv4/QcWtaXdxpFP
         2++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HndzIrwk0eloZ/VKZJ3ivaH1s8315qlKpsro16xZw70=;
        b=XXZH8MGe4qpOKEvLLVOOFh34gpg68PNvaLh7oTNFlfx7fpLKeelewkmUZT/swrkDvI
         oDRsu4S2Y9B3Kg/TRLT9hAkZZNY71z/YXc/QzqczVxJjiuL/slep9dU774Xi3QcBPFGn
         vqJYO7Hl6ZZX4eTdh6sqbuf83PxbzGqUdTiZPMY1OPA6Jm7ADbZ8tFd4gS4bEKiglfKU
         i3u1rvbmpV6zrcFEMeLjA1fIHg7vWAnLnnMjItWJxWayBQ2d9BnyO60kDw83yjzhtLAT
         DpC4PmT3hSTFf4L9AU6Wlf6cBvtHQsUsilsd9EmXVDLlUZ8KgC9aRqSmUAzRHL8Sv8Jr
         dshg==
X-Gm-Message-State: APjAAAXSUMD7nBHT92vR2LDrwaCjo4u8zQ5apd35mCnMNJ+kyLPxDGG9
        uUbDREr84EPxFSHz4UCKIhE=
X-Google-Smtp-Source: APXvYqxc7HGOD0D5gu8WnhNrsT1I3LmFfpI6lWg9smWBUfjHYlbiTNFFnqhLddSt9tTLEeru8OLm5Q==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr33615344pgl.103.1563282405436;
        Tue, 16 Jul 2019 06:06:45 -0700 (PDT)
Received: from brauner.io ([172.58.30.188])
        by smtp.gmail.com with ESMTPSA id a12sm42618252pje.3.2019.07.16.06.06.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 06:06:44 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:06:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190716130631.tohj4ub54md25dys@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> I think Vasily already has a clone3 patch for s390x with 435. 

A quick follow-up on this. Helge and Michael have asked whether there
are any tests for clone3. Yes, there will be and I try to have them
ready by the end of the this or next week for review. In the meantime I
hope the following minimalistic test program that just verifies very
very basic functionality (It's not pretty.) will help you test:

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

#ifndef CLONE_PIDFD
#define CLONE_PIDFD 0x00001000
#endif

#ifndef __NR_clone3
#define __NR_clone3 -1
#endif

static pid_t sys_clone3(struct clone_args *args)
{
	return syscall(__NR_clone3, args, sizeof(struct clone_args));
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

int main(int argc, char *argv[])
{
	int pidfd = -1;
	pid_t parent_tid = -1, pid = -1;
	struct clone_args args = {0};

	args.parent_tid = ptr_to_u64(&parent_tid); /* CLONE_PARENT_SETTID */
	args.pidfd = ptr_to_u64(&pidfd); /* CLONE_PIDFD */
	args.flags = CLONE_PIDFD | CLONE_PARENT_SETTID;
	args.exit_signal = SIGCHLD;

	pid = sys_clone3(&args);
	if (pid < 0) {
		fprintf(stderr, "%s - Failed to create new process\n", strerror(errno));
		exit(EXIT_FAILURE);
	}

	if (pid == 0) {
		printf("Child process with pid %d\n", getpid());
		exit(EXIT_SUCCESS);
	}

	printf("Parent process received child's pid %d as return value\n", pid);
	printf("Parent process received child's pidfd %d\n", *(int *)args.pidfd);
	printf("Parent process received child's pid %d as return argument\n",
	       *(pid_t *)args.parent_tid);

	if (wait_for_pid(pid))
		exit(EXIT_FAILURE);

	if (pid != *(pid_t *)args.parent_tid)
		exit(EXIT_FAILURE);

	close(pidfd);

	return 0;
}
