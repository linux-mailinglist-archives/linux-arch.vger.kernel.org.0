Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0857B1109
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjI1DFR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 23:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 23:05:16 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B280694;
        Wed, 27 Sep 2023 20:05:14 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 11:03:55
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 11:03:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] div64: Clean up errors in div64.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <109c2e25.8a9.18ad9be34be.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD8b7RRl6X++AA--.693W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2UT+K8AFQAEs+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBL
YWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogaW5jbHVkZS9hc20tZ2VuZXJp
Yy9kaXY2NC5oIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvZGl2NjQuaCBiL2lu
Y2x1ZGUvYXNtLWdlbmVyaWMvZGl2NjQuaAppbmRleCAxM2Y1YWE2OGE0NTUuLmVjNzViNzk5OGQw
NiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9kaXY2NC5oCisrKyBiL2luY2x1ZGUv
YXNtLWdlbmVyaWMvZGl2NjQuaApAQCAtNDIsNyArNDIsNyBAQAogICogTk9URTogbWFjcm8gcGFy
YW1ldGVyIEBuIGlzIGV2YWx1YXRlZCBtdWx0aXBsZSB0aW1lcywKICAqIGJld2FyZSBvZiBzaWRl
IGVmZmVjdHMhCiAgKi8KLSMgZGVmaW5lIGRvX2RpdihuLGJhc2UpICh7CQkJCQlcCisjIGRlZmlu
ZSBkb19kaXYobiwgYmFzZSkgKHsJCQkJCVwKIAl1aW50MzJfdCBfX2Jhc2UgPSAoYmFzZSk7CQkJ
CVwKIAl1aW50MzJfdCBfX3JlbTsJCQkJCQlcCiAJX19yZW0gPSAoKHVpbnQ2NF90KShuKSkgJSBf
X2Jhc2U7CQkJXApAQCAtMjE2LDcgKzIxNiw3IEBAIGV4dGVybiB1aW50MzJfdCBfX2RpdjY0XzMy
KHVpbnQ2NF90ICpkaXZpZGVuZCwgdWludDMyX3QgZGl2aXNvcik7CiAvKiBUaGUgdW5uZWNlc3Nh
cnkgcG9pbnRlciBjb21wYXJlIGlzIHRoZXJlCiAgKiB0byBjaGVjayBmb3IgdHlwZSBzYWZldHkg
KG4gbXVzdCBiZSA2NGJpdCkKICAqLwotIyBkZWZpbmUgZG9fZGl2KG4sYmFzZSkgKHsJCQkJXAor
IyBkZWZpbmUgZG9fZGl2KG4sIGJhc2UpICh7CQkJCVwKIAl1aW50MzJfdCBfX2Jhc2UgPSAoYmFz
ZSk7CQkJXAogCXVpbnQzMl90IF9fcmVtOwkJCQkJXAogCSh2b2lkKSgoKHR5cGVvZigobikpICop
MCkgPT0gKCh1aW50NjRfdCAqKTApKTsJXAotLSAKMi4xNy4xCg==
