Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97B1F516B
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jun 2020 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFJJpa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jun 2020 05:45:30 -0400
Received: from foss.arm.com ([217.140.110.172]:55952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgFJJpa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jun 2020 05:45:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8455F1F1;
        Wed, 10 Jun 2020 02:45:29 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87ACE3F73D;
        Wed, 10 Jun 2020 02:45:28 -0700 (PDT)
Date:   Wed, 10 Jun 2020 10:45:26 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/6] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200610094526.GE25945@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-5-git-send-email-Dave.Martin@arm.com>
 <77b02e4a-bfcf-90ef-90ca-73e878b7b649@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b02e4a-bfcf-90ef-90ca-73e878b7b649@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 09, 2020 at 01:39:03PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> I've not applied this patch yet, in case you want to make
> some changes in response to Will's comments.
> 
> I think all of the rest of the patches in the series are now
> applied (and pushed to master).
> 
> Thanks,

Ack, thanks
---Dave
