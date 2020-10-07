Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41B286831
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 21:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgJGTX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgJGTX6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 15:23:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E9C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 12:23:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQF2W-0019Ex-Uk; Wed, 07 Oct 2020 21:23:53 +0200
Message-ID: <11f40c1a85a118d8207a6f05fc574164a01af3a9.camel@sipsolutions.net>
Subject: Re: [RFC v7 20/21] um: host: add test programs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 21:23:51 +0200
In-Reply-To: <363dceeefe1c468adca17cec0b7ba4fad7c76ef3.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <363dceeefe1c468adca17cec0b7ba4fad7c76ef3.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> 
> +LKL_TEST_CALL(getpid, lkl_sys_getpid, 1)

Could that be unified with KUNIT somehow?

> +++ b/tools/um/tests/run.py
> @@ -0,0 +1,172 @@
> +#!/usr/bin/env python
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; version 2 of the License
> +#
> +# Author: Octavian Purdila <tavi@cs.pub.ro>
> +#
> +
> +from __future__ import print_function
> +
> +import argparse
> +import os
> +import subprocess
> +import sys
> +import tap13

ok, I see now, you're doing something with TAP (test anything
protocol)...

Hmm. I must say I'm not a fan of adding a whole testing framework to the
kernel like that, even if it's pretty simple.

> +import xml.etree.ElementTree as ET
> +
> +from junit_xml import TestSuite, TestCase

yuck

Let's see if you can use KUNIT instead. Anything beyond that doesn't
really need to live in the kernel, IMHO.

johanens

