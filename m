Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0D72CBA1
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjFLQfJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjFLQer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 12:34:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F82E4A;
        Mon, 12 Jun 2023 09:34:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686587682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYtSFWUwn9WeOG6ywaxCGLfcJEaLF6HVkDFCg6qR+Ck=;
        b=LQsZ9l51ZyERdBDY/oRFCecvIwE+OJgolEZLC4ju8TGaR2glRAeJkEh/gxmEEQdxccSBRn
        Nkl9fXN70FUGW8Vrk6QTB/EDkIx7KZeYmZ+6hqkw88Wj6xBlfn1lu+Axpx6v3exlkZA5qF
        xn2GoaB3iJJ9RyU+3AX5GakUlntQiVF6Hibsxe8KSuHme8DQAkGCpjlVrcKHcoU8CP84Gi
        tUjnTx26rAeD+Vkfrk88Jsc7seiQoKzogTWC3YOM2gU68500pq1a60LRxCGTeSHmS+D7Za
        Sh+Iz2iXp9c3W8f61IDOAPWsoCQmy1klWt0eQN6qeuRKQF37olv78N0KfobMdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686587682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYtSFWUwn9WeOG6ywaxCGLfcJEaLF6HVkDFCg6qR+Ck=;
        b=LsxfhaCWfQgNL2N4GKoci45k10Ud9BYivUCi/b7WfELtf3iXReMHlqJTp3PRRnpDSGYtJr
        yTdbFkV+sUvvFNAA==
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, dave.hansen@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 8/9] powerpc: Add HOTPLUG_SMT support
In-Reply-To: <c0fe7b2c-1ce7-3d2f-0175-e61920fc3dee@linux.ibm.com>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-8-mpe@ellerman.id.au>
 <5752a488-be54-61a0-6d18-647456abc4ee@linux.ibm.com>
 <6e86aedb-9349-afd4-0bcb-1949e828f997@linux.ibm.com> <87h6rf81n9.ffs@tglx>
 <c0fe7b2c-1ce7-3d2f-0175-e61920fc3dee@linux.ibm.com>
Date:   Mon, 12 Jun 2023 18:34:41 +0200
Message-ID: <87cz207i72.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12 2023 at 17:20, Laurent Dufour wrote:
> On 10/06/2023 23:10:02, Thomas Gleixner wrote:
>> This needs more thoughts to avoid a completely inconsistent duct tape
>> mess.
>
> Despite the test against smt_enabled_at_boot, mentioned above, I can't see
> anything else to rework. Am I missing something?

See my comments on the core code changes.

>> Btw, the command line parser and the variable smt_enabled_at_boot being
>> type int allow negative number of threads too... Maybe not what you want.
>
> I do agree, it should an unsigned type.

I assume you'll fix that yourself. :)

Thanks,

        tglx
