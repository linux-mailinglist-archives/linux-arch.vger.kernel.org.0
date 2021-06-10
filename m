Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2F3A296A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJKgx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 06:36:53 -0400
Received: from foss.arm.com ([217.140.110.172]:56492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJKgw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 06:36:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E21BD6E;
        Thu, 10 Jun 2021 03:34:56 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BCC23F694;
        Thu, 10 Jun 2021 03:34:55 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:33:54 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210610103354.GO4187@arm.com>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
 <20210603154034.GH4187@arm.com>
 <20210603165134.GF4257@sirena.org.uk>
 <20210603180429.GI20338@arm.com>
 <20210607112536.GI4187@arm.com>
 <20210607181212.GD17957@arm.com>
 <20210608113318.GA4200@sirena.org.uk>
 <20210608151914.GJ4187@arm.com>
 <2318f36a-0b81-0e6c-cf6e-ce4167471c82@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2318f36a-0b81-0e6c-cf6e-ce4167471c82@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 10:42:41AM -0500, Jeremy Linton wrote:
> On 6/8/21 10:19 AM, Dave Martin wrote:
> >On Tue, Jun 08, 2021 at 12:33:18PM +0100, Mark Brown via Libc-alpha wrote:
> >>On Mon, Jun 07, 2021 at 07:12:13PM +0100, Catalin Marinas wrote:
> >>
> >>>I don't think we can document all the filters that can be added on top
> >>>various syscalls, so I'd leave it undocumented (or part of the systemd
> >>>documentation). It was a user space program (systemd) breaking another
> >>>user space program (well, anything with a new enough glibc). The kernel
> >>>ABI was still valid when /sbin/init started ;).
> >>
> >>Indeed.  I think from a kernel point of view the main thing is to look
> >>at why userspace feels the need to do things like this and see if
> >>there's anything we can improve or do better with in future APIs, part
> >>of the original discussion here was figuring out that there's not really
> >>any other reasonable options for userspace to implement this check at
> >>the minute.
> >
> >Ack, that would be my policy -- just wanted to make it explicit.
> >It would be good if there were better dialogue between the systemd
> >and kernel folks on this kind of thing.
> >
> >SECCOMP makes it rather easy to (attempt to) paper over kernel/user API
> >design problems, which probably reduces the chance of the API ever being
> >fixed properly, if we're not careful...
> 
> Well IMHO the problem is larger than just BTI here, what systemd is trying
> to do by fixing the exec state of a service is admirable but its a 90%
> solution without the entire linker/loader being in a more privileged
> context. While BTI makes finding a generic gadget that can call mprotect
> harder, it still seems like it might just be a little too easy. The secomp
> filter is providing a nice bonus by removing the ability to disable BTI via
> mprotect without also disabling X. So without moving more of the linker into
> the kernel its hard to see how one can really lock down X only pages.
> 
> Anyway, i'm testing this on rawhide now.
> 
> Thanks!

Well, I agree that there are larger issues here.  But we need to be
realistic and try not to do too much damage to future maintainability.

Note, your "bonus" is really a feature-like bug.  This is what we
should be trying to avoid IMHO: if it's important, it needs to be
designed and guaranteed.  Something that works by accident is likely to
get broken again by accident in the future.

Cheers
---Dave
