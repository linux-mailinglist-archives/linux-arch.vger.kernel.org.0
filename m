Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C670D94E
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjEWJme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjEWJmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 05:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDD130;
        Tue, 23 May 2023 02:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81D2462E24;
        Tue, 23 May 2023 09:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E6C433EF;
        Tue, 23 May 2023 09:42:29 +0000 (UTC)
Date:   Tue, 23 May 2023 10:42:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/7] arm64: Update Documentation/arm references
Message-ID: <ZGyKgvDfl4mree82@arm.com>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-4-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519164607.38845-4-corbet@lwn.net>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023 at 10:46:03AM -0600, Jonathan Corbet wrote:
> The Arm documentation has moved to Documentation/arch/arm; update
> references under arch/arm64 to match.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
