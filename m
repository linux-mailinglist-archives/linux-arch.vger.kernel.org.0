Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930CC286206
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJGPYc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPY1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:24:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCFC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:24:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBIg-000zPr-8r; Wed, 07 Oct 2020 17:24:18 +0200
Message-ID: <5caf34d16a0f2816b47cd8712ca7d59e9733a815.camel@sipsolutions.net>
Subject: Re: [RFC v7 06/21] scritps: um: suppress warnings if SRCARCH=um
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:24:17 +0200
In-Reply-To: <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This commit fixes numbers of warning messages about leaked CONFIG
> options.

No it doesn't ... it suppresses them, not a fan at all.

> nommu mode of UML requires copies of kernel headers to offer
> syscall-like API for the library users.  Thus, the warnings are to be
> avoided to function this exposure of API.

I don't see that here, so maybe make that part of the patch where it
actually happens, with a big comment, and maybe only when actually
building for NOMMU/LKL?

johannes


