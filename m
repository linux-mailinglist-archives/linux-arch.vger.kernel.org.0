Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA631D715
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 10:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhBQJmz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 04:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhBQJmz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 04:42:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D352D64E33;
        Wed, 17 Feb 2021 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613554934;
        bh=VhEXCOKjvsWaqJ+vpm1ijhGk5+VfFUrzvF1popO2QFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Id5+KHYoDWuGYdQo1dE1OpLx2YfU4ZZIv7fwOocAdnWBNvv+9EEXvMIvCwQlHErze
         RPaDingzEgyhCyhwogev0wJA8ZLUnxNsOVqiEwhvWvK/62+gGBkJZxNhK8j1jVRxdZ
         r11RDZks7Npi0HvWJpc6W0k3sfvfckOSwUePsZdjnMhwOFSDQ0QRWD40EpyX1wKszm
         l+3u2zPys0bfqNEPUsgIsZXSR8TykKLd+eZP+7uAIpkvsqM42gyfZHlCS6M76ccFb3
         FjBMekm+rcjtuezgFaWQCZtCW8Ju1GnKHkBLZG8TpdTZ0F3+zk26tE88g+O67yDiKk
         y//9GW5zJRZvg==
Date:   Wed, 17 Feb 2021 09:42:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Preeti Nagar <pnagar@codeaurora.org>, maz@kernel.org,
        ardb@kernel.org
Cc:     arnd@arndb.de, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-arch@vger.kernel.org,
        casey@schaufler-ca.com, ndesaulniers@google.com,
        dhowells@redhat.com, ojeda@kernel.org, psodagud@codeaurora.org,
        nmardana@codeaurora.org, rkavati@codeaurora.org,
        vsekhar@codeaurora.org, mreichar@codeaurora.org, johan@kernel.org,
        joe@perches.com, jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate
 page
Message-ID: <20210217094205.GA3570@willie-the-truck>
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Please include arm64 and kvm folks for threads involving the stage-2 MMU]

On Tue, Feb 16, 2021 at 03:47:52PM +0530, Preeti Nagar wrote:
> The changes introduce a new security feature, RunTime Integrity Check
> (RTIC), designed to protect Linux Kernel at runtime. The motivation
> behind these changes is:
> 1. The system protection offered by Security Enhancements(SE) for
> Android relies on the assumption of kernel integrity. If the kernel
> itself is compromised (by a perhaps as yet unknown future vulnerability),
> SE for Android security mechanisms could potentially be disabled and
> rendered ineffective.
> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
> checks to each stage of the boot-up process, to assert the authenticity
> of all secure software images that the device executes.  However, due to
> various vulnerabilities in SW modules, the integrity of the system can be
> compromised at any time after device boot-up, leading to un-authorized
> SW executing.
> 
> The feature's idea is to move some sensitive kernel structures to a
> separate page and monitor further any unauthorized changes to these,
> from higher Exception Levels using stage 2 MMU. Moving these to a
> different page will help avoid getting page faults from un-related data.
> The mechanism we have been working on removes the write permissions for
> HLOS in the stage 2 page tables for the regions to be monitored, such
> that any modification attempts to these will lead to faults being
> generated and handled by handlers. If the protected assets are moved to
> a separate page, faults will be generated corresponding to change attempts
> to these assets only. If not moved to a separate page, write attempts to
> un-related data present on the monitored pages will also be generated.
> 
> Using this feature, some sensitive variables of the kernel which are
> initialized after init or are updated rarely can also be protected from
> simple overwrites and attacks trying to modify these.

Although I really like the idea of using stage-2 to protect the kernel, I
think the approach you outline here is deeply flawed. Identifying "sensitive
variables" of the kernel to protect is subjective and doesn't scale.
Furthermore, the triaging of what constitues a valid access is notably
absent from your description and is assumedly implemented in an opaque blob
at EL2.

I think a better approach would be along the lines of:

  1. Introduce the protection at stage-1 (like we already have for mapping
     e.g. the kernel text R/O)

  2. Implement the handlers in the kernel, so the heuristics are clear.

  3. Extend this to involve KVM, so that the host can manage its own
     stage-2 to firm-up the stage-1 protections.

I also think we should avoid tying this to specific data structures.
Rather, we should introduce a mechanism to make arbitrary data read-only.

I've CC'd Ard and Marc, as I think they've both been thinking about this
sort of thing recently as well.

Will
