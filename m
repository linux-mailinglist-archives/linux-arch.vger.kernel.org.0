Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CC48A38E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 00:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbiAJXY0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 18:24:26 -0500
Received: from cloud48395.mywhc.ca ([173.209.37.211]:38012 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiAJXYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 18:24:25 -0500
X-Greylist: delayed 1453 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2022 18:24:25 EST
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:43128 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1n73e5-0003XM-9d; Mon, 10 Jan 2022 18:00:09 -0500
Message-ID: <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
From:   Olivier Langlois <olivier@trillion01.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Mon, 10 Jan 2022 18:00:07 -0500
In-Reply-To: <87o84juwhg.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
         <20211213225350.27481-1-ebiederm@xmission.com>
         <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
         <87sfu3b7wm.fsf@email.froward.int.ebiederm.org> <YdniQob7w5hTwB1v@osiris>
         <87ilurwjju.fsf@email.froward.int.ebiederm.org>
         <87o84juwhg.fsf@email.froward.int.ebiederm.org>
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2022-01-10 at 15:11 -0600, Eric W. Biederman wrote:
> 
> 
> I have been able to confirm that changing wait_event_interruptible to
> wait_event_killable was the culprit.  Something about the way
> systemd-coredump handles coredumps is not compatible with
> wait_event_killable.

This is my experience too that systemd-coredump is doing something
unexpected. When I tested the patch:
https://lore.kernel.org/lkml/cover.1629655338.git.olivier@trillion01.com/

to make sure that the patch worked, sending coredumps to systemd-
coredump was making systemd-coredump, well, core dump... Not very
useful...

Sending the dumps through a pipe to anything else than systemd-coredump
was working fine.

