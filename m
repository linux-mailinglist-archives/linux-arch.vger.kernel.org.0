Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5FA4D65
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2019 05:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfIBDGT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Sep 2019 23:06:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41187 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbfIBDGS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 1 Sep 2019 23:06:18 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFN82G7vz9sDB; Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 70ed86f4de5bd74dd2d884dcd2f3275c4cfe665f
In-Reply-To: <20190829155021.2915-2-maxiwell@linux.ibm.com>
To:     "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
        linuxppc-dev@ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, andmike@linux.ibm.com,
        linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, cclaudio@linux.ibm.com,
        "Maxiwell S . Garcia" <maxiwell@linux.ibm.com>,
        bauerman@linux.ibm.com
Subject: Re: [PATCH v2 1/2] powerpc: Add PowerPC Capabilities ELF note
Message-Id: <46MFN82G7vz9sDB@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-08-29 at 15:50:20 UTC, "Maxiwell S. Garcia" wrote:
> From: Claudio Carvalho <cclaudio@linux.ibm.com>
> 
> Add the PowerPC name and the PPC_ELFNOTE_CAPABILITIES type in the
> kernel binary ELF note. This type is a bitmap that can be used to
> advertise kernel capabilities to userland.
> 
> This patch also defines PPCCAP_ULTRAVISOR_BIT as being the bit zero.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> [ maxiwell: Define the 'PowerPC' type in the elfnote.h ]
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>

Series applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/70ed86f4de5bd74dd2d884dcd2f3275c4cfe665f

cheers
