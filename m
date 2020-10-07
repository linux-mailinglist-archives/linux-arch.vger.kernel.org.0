Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF62861F5
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgJGPVA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPU7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:20:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B73C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:20:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBFH-000zIk-Jj; Wed, 07 Oct 2020 17:20:47 +0200
Message-ID: <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:20:46 +0200
In-Reply-To: <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This patch moves underlying OS dependent part under arch/um to tools/um
> directory so that arch/um code does not need to build host build
> facilities (e.g., libc).

Hmm. On the one hand, that build separation seems sensible, but on the
other hand this stuff *does* fundamentally belong to arch/um/, and it's
not a "tool" like basically everything else there that is a pure
userspace application to run *inside* the kernel, not *part of* it.

For that reason, I don't really like this much.


>  tools/um/uml/Build                            | 48 +++++++++++++++++++
>  tools/um/uml/drivers/Build                    | 10 ++++

Also, what's with the names here? What's wrong with "Makefile"?


I'm also not sure I see how this is built at all from the top level
Makefile? Oh. I think Anton said it doesn't ... that alone would be a
reason not to do it I guess.


So why do you think it must be under tools/? Even if you consider "lkl"
a "tool", that doesn't mean it must be there. I also consider a UML
binary ("linux") a "tool" in my simulation environment, etc.


And even LKL, which is the eventual goal here - why would you consider
that a "tool"? I don't think we should.

johannes

