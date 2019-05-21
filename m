Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC7B2522F
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2019 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfEUOck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 May 2019 10:32:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33864 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfEUOck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 May 2019 10:32:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so8560302plz.1
        for <linux-arch@vger.kernel.org>; Tue, 21 May 2019 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CyEpPRrV9RS3Zg004GbU3opzLF2psDEeRox6G2Dzgi4=;
        b=R7tC9jV5a+mxQO62x+PWvbdzprD7UnwlstIi1E921IR8MQwvIjqpWXEjFq96wgtFnG
         fTY3nrMJ7vCArpwoCVItDxzdQ40Qirw2JBMtmG9CODfWHtTXbOzlgqZAKYfvraG5V/E/
         frjGG7jnSr228cVlsj/AYjMiDaehudskW3T4AmnYaTekKHbr2YRWH9MAzfQSuPvXNkig
         nGR3hP9fBOFFBpPON8OQVuBm2SSMmqqE80W+7bGmI4VUShRRrCVcCUx8VLhizIP/+v8d
         eMhf2YFuLCOUzRqivSwvxO5aWPP4xWsn3q69TEqczL5TXIDQcUFBiSLNtQvcQ37Ukm91
         n7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CyEpPRrV9RS3Zg004GbU3opzLF2psDEeRox6G2Dzgi4=;
        b=G4AWrvWZr3pv26vKEhhnNW8sR2Jb/MdPZqa5eAikYv5hjPqtwif49Ybr5oMy9rPqcR
         3bKRJuDJrTkfJij3CDRhRYUT/mzyiNNRJYhcBUfmIL+cDU3MXlHfO6XeK6+5vC3VvSaE
         6UJLhL5F8WhOH3sRRW0KOR/gJ4kgT7en69QFmVi66zo9HoCGSx4DLAYV2niq0Ul4ztNp
         b673cWIbj+AEod4q36PLl3i7Ht5rCr2JemTIXS/MdqN8+HYHBIo/7n8mbxYhspC0Tva5
         E3AAa5HH/rDVXkV9WM/W4qnPnVZoja/Kg00l9Rg3cTuKDGnN55YpfvU9L/KAGMmhvPFG
         gQow==
X-Gm-Message-State: APjAAAVm80sRIkZ6ImPcAbyBe4S+kbX27qV9u9EuieFPd9/k5BgkUfcT
        n9AorRFjMBEAuY0ru5gRpJX7zA==
X-Google-Smtp-Source: APXvYqzfSnHKDaWx/UeH1zZV9VxL0yBVD2SxGAqwuR5ORrqMhe2WMo1TCAFF94hkLIeOM4eQM6MVkw==
X-Received: by 2002:a17:902:ba88:: with SMTP id k8mr9263163pls.16.1558449159148;
        Tue, 21 May 2019 07:32:39 -0700 (PDT)
Received: from brauner.io ([208.54.39.182])
        by smtp.gmail.com with ESMTPSA id q5sm25819914pfb.51.2019.05.21.07.32.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 07:32:38 -0700 (PDT)
Date:   Tue, 21 May 2019 16:32:22 +0200
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Cc:     akpm@linux-foundation.org, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        dancol@google.com, serge@hallyn.com, surenb@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/2] pid: add pidfd_open()
Message-ID: <20190521143220.crb2zyvdov3fl4g7@brauner.io>
References: <20190520155630.21684-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520155630.21684-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 20, 2019 at 05:56:29PM +0200, Christian Brauner wrote:
> This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
> pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
> process that is created via traditional fork()/clone() calls that is only
> referenced by a PID:
> 
> int pidfd = pidfd_open(1234, 0);
> ret = pidfd_send_signal(pidfd, SIGSTOP, NULL, 0);
> 
> With the introduction of pidfds through CLONE_PIDFD it is possible to
> created pidfds at process creation time.
> However, a lot of processes get created with traditional PID-based calls
> such as fork() or clone() (without CLONE_PIDFD). For these processes a
> caller can currently not create a pollable pidfd. This is a problem for
> Android's low memory killer (LMK) and service managers such as systemd.
> Both are examples of tools that want to make use of pidfds to get reliable
> notification of process exit for non-parents (pidfd polling) and race-free
> signal sending (pidfd_send_signal()). They intend to switch to this API for
> process supervision/management as soon as possible. Having no way to get
> pollable pidfds from PID-only processes is one of the biggest blockers for
> them in adopting this api. With pidfd_open() making it possible to retrieve
> pidfds for PID-based processes we enable them to adopt this api.
> 
> In line with Arnd's recent changes to consolidate syscall numbers across
> architectures, I have added the pidfd_open() syscall to all architectures
> at the same time.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

This now also carries a Reviewed-by from David.

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-api@vger.kernel.org

I've moved pidfd_open() into my for-next branch together with Joel's
pidfd polling changes. Everything is based on v5.2-rc1.

The chosen syscall number for now is 434. David is going to send out
another pile of mount api related syscalls. I'll coordinate with him
accordingly prior to the 5.3 merge window.

Thanks!
Christian
