Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AE158595
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2020 23:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJWax (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Feb 2020 17:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgBJWax (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Feb 2020 17:30:53 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F01F20733;
        Mon, 10 Feb 2020 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581373852;
        bh=54nkkLQpkIxaBNzxm98DpOSXoNRzc6TpxqRSEf7qsvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yE9Hpuo7Y6xYunvkNsz5dQ+EYq88XNQbx27h4AiW1m0qX+2w7LbvaVX3rRyRX8DPz
         huaTwMLmkRUH7T0j7B6bCEsYnzEnSAlU18DlgjTZW+OxjGw3wsZcF3awO5rV2MMhz6
         MzVw96chGFwyZ1YY3N9vhQxwWD7wTdBt0j4OmQ1s=
Date:   Mon, 10 Feb 2020 14:30:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: make more kernel-space headers mandatory
Message-Id: <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
In-Reply-To: <20200210175452.5030-1-masahiroy@kernel.org>
References: <20200210175452.5030-1-masahiroy@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Feb 2020 02:54:52 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> Change a header to mandatory-y if both of the following are met:
> 
> [1] At least one architecture (except um) specifies it as generic-y in
>     arch/*/include/asm/Kbuild
> 
> [2] Every architecture (except um) either has its own implementation
>     (arch/*/include/asm/*.h) or specifies it as generic-y in
>     arch/*/include/asm/Kbuild

(reads Documentation/kbuild/makefiles.rst to remember what these things
do).

Why are we making this change?  What's the benefit?


