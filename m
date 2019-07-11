Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99065314
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGKIXV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 04:23:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49221 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfGKIXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 04:23:20 -0400
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlUMG-0001Fh-2N; Thu, 11 Jul 2019 10:23:16 +0200
Date:   Thu, 11 Jul 2019 10:23:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christopher Lameter <cl@linux.com>
cc:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
In-Reply-To: <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
Message-ID: <alpine.DEB.2.21.1907111022400.1889@nanos.tec.linutronix.de>
References: <20190711030339.20892-1-npiggin@gmail.com> <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 11 Jul 2019, Christopher Lameter wrote:

> On Thu, 11 Jul 2019, Nicholas Piggin wrote:
> 
> > Remove page table allocator "quicklists". These have been around for a
> > long time, but have not got much traction in the last decade and are
> > only used on ia64 and sh architectures.
> 
> I also think its good to remove this code. Note sure though if IA64
> may still have a need of it. But then its not clear that the IA64 arch is
> still in use. Is it still maintained?

It's kept alive
