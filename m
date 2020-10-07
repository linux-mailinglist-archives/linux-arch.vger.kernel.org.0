Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E628680B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgJGTFl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 15:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgJGTFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 15:05:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE28C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 12:05:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQEkl-0018fr-81; Wed, 07 Oct 2020 21:05:31 +0200
Message-ID: <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
Subject: Re: [RFC v7 12/21] um: nommu: system call interface and application
 API
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 21:05:30 +0200
In-Reply-To: <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> 
> +++ b/arch/um/nommu/include/uapi/asm/syscalls.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

That doesn't really make sense - if you use LKL you're linking Linux, so
you can't use this "WITH Linux-syscall-note"?

> +#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
> +#define __UM_NOMMU_UAPI_SYSCALLS_H

[snip]

This file really worries me, it includes half the world and (re)defines
the other half ... How is this ever going to be maintained?

> index 000000000000..ec7356c0dee9
> --- /dev/null
> +++ b/arch/um/scripts/headers_install.py
> @@ -0,0 +1,197 @@
> +#!/usr/bin/env python

might want to make that explicitly 'python3', some newer distros (e.g.
ubuntu 20.04) are now shipping without a 'python' by default.

> +def has_lkl_prefix(w):
> +  return w.startswith("lkl") or w.startswith("_lkl") or w.startswith("__lkl") \
> +         or w.startswith("LKL") or w.startswith("_LKL") or w.startswith("__LKL")


> +        content = re.sub(re.compile("(\/\*(\*(?!\/)|[^*])*\*\/)", re.S|re.M), " ", open(h).read())
> 
> +    dir = os.path.dirname(h)
> +    out_dir = args.path + "/" + re.sub("(" + srctree + "/arch/um/nommu/include/uapi/|arch/um/nommu/include/generated/uapi/|include/generated/uapi/|include/generated|" + install_hdr_path + "/include/)(.*)", "lkl/\\2", dir)


you have some very long lines in places, I'm sure you could fix that
(e.g. the last one by doing something with '|'.join([...]))

johannes

