Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CE4EA3C5
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 01:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiC1XcF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiC1XcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 19:32:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9762942ECC;
        Mon, 28 Mar 2022 16:30:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2102820DEDDE;
        Mon, 28 Mar 2022 16:30:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2102820DEDDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648510220;
        bh=VCBmKOU3bhYrRKyxH/RJtKwil2TxccJ2CJcGM4eyu/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noDMiblwX6L3HSRCCnVnic33xfGbHmfkE9BfxIdWCOwQZIAEzf9V8AlRBxGPWkf1f
         RRJleWDD5u/STBlTvRlNOnZQSj0dLyiBOV00pF+DZNA4LRInwY2qIlNjfbgghSrw1g
         z71ppjoAxGGZF9nJLDxtSf4Tx/uLk31XJYjFnNCI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     mathieu.desnoyers@efficios.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, rostedt@goodmis.org,
        beaub@linux.microsoft.com
Subject: Re: Comments on new user events ABI
Date:   Mon, 28 Mar 2022 16:30:10 -0700
Message-Id: <20220328233010.2636-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1283359416.196715.1648499713041.JavaMail.zimbra@efficios.com>
References: <1283359416.196715.1648499713041.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> ----- On Mar 28, 2022, at 4:24 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > Hi Beau, Hi Steven,
> > 
> > I've done a review of the trace events ABI, and I have a few comments.
> > Sorry for being late to the party, but I only noticed this new ABI recently.
> > Hopefully we can improve this ABI before the 5.18 release.
> > 
> 
> Also a bit of testing shows that dyn_event_add() is called without holding the event_mutex.
> Has this been tested with lockdep ?

Sorry, looks like I've been running with LOCKDEP_SUPPORT without it on :(
I now have both CONFIG_LOCKDEP and CONFIG_LOCK_DEBUGGING_SUPPORT.

You are right about this, thanks! I've sent a patch.

Link: https://lore.kernel.org/all/20220328223225.1992-1-beaub@linux.microsoft.com/

Thanks,
-Beau
