Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8413D8D3
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgAPLTP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 06:19:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34868 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPLTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jan 2020 06:19:15 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1is3B9-0000wC-Lv; Thu, 16 Jan 2020 11:19:11 +0000
Date:   Thu, 16 Jan 2020 12:19:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: wireup clone3 syscall
Message-ID: <20200116111910.b3vhwudsdb4oe5b2@wittgenstein>
References: <20200116000948.17646-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200116000948.17646-1-vgupta@synopsys.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 15, 2020 at 04:09:48PM -0800, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
