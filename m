Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAC2861C0
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgJGPCw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgJGPCw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:02:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD9C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:02:52 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQAxm-000ykQ-Fk; Wed, 07 Oct 2020 17:02:42 +0200
Message-ID: <6d8dd929722e419894824a07792ac8c5b2659de9.camel@sipsolutions.net>
Subject: Re: [RFC v7 18/21] um: host: add utilities functions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Hajime Tazaki <thehajime@gmail.com>,
        linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        retrage01@gmail.com, linux-arch@vger.kernel.org
Date:   Wed, 07 Oct 2020 17:02:41 +0200
In-Reply-To: <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
         <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-10-07 at 15:53 +0100, Anton Ivanov wrote:
> 
> These are actually different on different architectures. These look
> like the x86 values.
> 
> IMHO a kernel strerror() would be the right way of dealing with this
> in the long term (i understand that we cannot call the platform one,
> because it may be different from the internal Linux errors). It will
> be useful in a lot of other places.
> 
> If we leave it as is, we need to make this arch specific at some
> point.
> 
> > +
> > +static const char * const lkl_err_strings[] = {
> > +	"Success",
> > +	"Operation not permitted",

Might be possible to more or less address this (except for arch-specific 
errors that don't always exist) but using C99 initializers?

[0] = "Success",
[EPERM] = "Operation not permitted",
..

johannes

