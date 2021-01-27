Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E1306854
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 00:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhA0X4c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 18:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhA0X4N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 18:56:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAFCC061573;
        Wed, 27 Jan 2021 15:55:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E6EB31F44BF5
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ptrace: restore the previous single step reporting
 behavior
In-Reply-To: <877do3gaq9.fsf@m5Zedd9JOGzJrf0> (Yuxuan Shui's message of "Sat,
        23 Jan 2021 03:21:32 -0800 (PST)")
Organization: Collabora
References: <877do3gaq9.fsf@m5Zedd9JOGzJrf0>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 27 Jan 2021 20:55:20 -0300
Message-ID: <87zh0u540n.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Yuxuan Shui <yshuiv7@gmail.com> writes:

> Commit 64eb35f701f04b30706e21d1b02636b5d31a37d2 changed when single step
> is reported.
>
> Specifically, the report_single_step is changed so that single steps are
> only reported when both SYSCALL_EMU and _TIF_SINGLESTEP are set, while
> previously they are reported when _TIF_SINGLESTEP is set without
> _TIF_SYSCALL_EMU being set.
>
> This behavior change breaks rr [1]
>
> This commit restores the old behavior.
>
> [1]: https://github.com/rr-debugger/rr/issues/2793
>
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>

Looks correct to me.

To gather the right attention, you should directly CC the correct maintainers.

Fixes: 64eb35f701f0 ("ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag")
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
