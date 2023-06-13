Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A672E465
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbjFMNlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbjFMNlm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 09:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DCB4;
        Tue, 13 Jun 2023 06:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAFA56364E;
        Tue, 13 Jun 2023 13:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C402BC433D9;
        Tue, 13 Jun 2023 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686663699;
        bh=wqgHDdNHl4SuNVKWfAX2txt43wu3ebaWvZvejLsScFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLdmV782DHcs7ftY6nbIQjNrKhjXfV3ybhU/eojgaNllQ1ekov+M3v681sIgFlK3Z
         MJOh3IeOLAOVOAEDOkMyPGrPmWOFi23t8PlrlPMpOSfg94RRIrdev6uyHrou5mIzlX
         PwNB4JvP05lOO8hMVxbEV/oEdZ5v/SPyRvLp4vZRDYAS1zaxyJ+4Z1RRnzZKgFf1fj
         TF3vkjezzQWdtuZVeniUSxaRYLpB+Zlu9fh+vGgnnEsSs+B2md0gCKvzrc7H7epFQP
         RT2utDNW27X6kdnIZVLzjU8zTxssVnOphahlh0q/7cBJaDP0vHtl3hT3P+HFu7MaZj
         gFZln7zSPJwnw==
Date:   Tue, 13 Jun 2023 16:41:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 4/5] mm: Fix a dangling Documentation/arm64 reference
Message-ID: <20230613134107.GU52412@kernel.org>
References: <20230613094606.334687-1-corbet@lwn.net>
 <20230613094606.334687-5-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094606.334687-5-corbet@lwn.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 13, 2023 at 03:46:05AM -0600, Jonathan Corbet wrote:
> The arm64 documentation has moved under Documentation/arch/.  Fix up a
> reference in mm/mremap.c to match.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mremap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index b11ce6c92099..3185724d8b13 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -914,7 +914,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	 * mapping address intact. A non-zero tag will cause the subsequent
>  	 * range checks to reject the address as invalid.
>  	 *
> -	 * See Documentation/arm64/tagged-address-abi.rst for more information.
> +	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
> +	 * information.
>  	 */
>  	addr = untagged_addr(addr);
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
